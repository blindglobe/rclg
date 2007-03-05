;;; RCLG: R-CommonLisp Gateway

;;; Copyright (c) 2005--2007, <rif@mit.edu>
;;;                           AJ Rossini <blindglobe@gmail.com>
;;; All rights reserved.
;;;
;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions are
;;; met:
;;;
;;;     * Redistributions of source code must retain the above copyright
;;;       notice, this list of conditions and the following disclaimer.
;;;     * Redistributions in binary form must reproduce the above
;;;       copyright notice, this list of conditions and the following disclaimer
;;;       in the documentation and/or other materials provided with the
;;;       distribution.
;;;     * The names of the contributors may not be used to endorse or
;;;       promote products derived from this software without specific
;;;       prior written permission.
;;;
;;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;;; "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;;; LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
;;; A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
;;; OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
;;; SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
;;; LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
;;; DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
;;; THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
;;; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
;;; OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


;;; Author:      rif@mit.edu
;;; Maintainers: rif@mit.edu,
;;;              AJ Rossini <blindglobe@gmail.com>

;;; Intent: primary evaluation tool for R code; return values are R SEXPs. 

(defpackage :rclg-control
  (:use :common-lisp :cffi :rclg-types :rclg-foreigns :rclg-access
	:rclg-init :rclg-convert :rclg-util)
  (:export :r :rnb :rnbi :rnr))

(in-package :rclg-control)

;;; Internal

(defun rname-to-robj (name)
  "If R has a mapping for name (name is a string), returns the SEXP
that points to it, otherwise returns NIL."
  (with-foreign-string (ident-foreign name)
    (let ((foreign-value
	   (%rf-find-var (%rf-install ident-foreign) *r-global-env*)))
      (when(r-bound-p foreign-value)
	foreign-value))))

(defun rname-to-rfun (name)
  "If R has a mapping for name (name is a string), returns the SEXP
that points to it, otherwise returns NIL."
  (and (rname-to-robj name)
       (with-foreign-string (ident-foreign name)
	 (let ((foreign-value
		(%rf-find-fun (%rf-install ident-foreign) *r-global-env*)))
	   (when (r-bound-p foreign-value)
	     foreign-value)))))

(defun sexp-length (args)
  (+ 1 (length args) (- (count-keywords args))))

(defun count-keywords (args)
  (count-if #'keywordp args))

(defun r-call (name &rest args)
  "Does the actual call to R.  r-call converts args into R objects.
Returns an unprotected, unconverted R object."
  (let ((func (rname-to-rfun name)))
    (if (not func)
	(error "Cannot find function ~A" name)      
	(let ((exp (%rf-protect 
		    (%rf-alloc-vector #.(sexp-elt-type :langsxp) (sexp-length args)))))
	  (r-setcar exp func)
	  (parse-args (r-cdr exp) args)
	  (prog1 (with-r-traps (r-eval exp))
	    (%rf-unprotect 1))))))  ;; r-call

(defvar *rclg-last-error* nil)

(defun get-r-error ()
  "Use R's standard error holding mechanism to return the last error
that occured.  Should we push the result into a global variable,
something like *rclg-last-error* which could be originally nil?"
  ;; (r-call "geterrmessage"))
  ;; (r "geterrmessage"))
  (setf *rclg-last-error* (r-call "geterrmessage")))

(defun r-eval (expr)
  "raw R expression evaluation."
  (with-foreign-object (e :int)
    (let ((res
	   (with-r-mutex
	     (setf (mem-ref e :int) 0)
	     (%r-try-eval expr *r-global-env* e))))
      (if (not (= (mem-ref e :int) 0))
	  (error "Bad expr: ~A" (get-r-error))
	  res))))

(defun parse-args (exp args)
  (do ((arglist args (cdr arglist)))
      ((null arglist) nil)
    (let ((cur (car arglist)))
      (if (keywordp cur)
	  (progn
	    (parse-keyword exp cur (cadr arglist))
	    (setf arglist (cdr arglist)))
	(parse-regular-arg exp cur))
      (setf exp (r-cdr exp))
      (when (and (typep cur 'sexp-holder)
		 (eq (slot-value cur 'protected) 'r-protect-until-used))
	(%rf-unprotect-ptr (slot-value cur 'sexp))
	(setf (slot-value cur 'protected) nil)))))

(defun parse-keyword (exp kwd arg)
  (r-setcar exp (convert-to-r arg))
  (with-foreign-string (f (string-downcase (symbol-name kwd)))
    (%set-tag exp (%rf-install f))))

(defun parse-regular-arg (exp arg)
  (r-setcar exp (convert-to-r arg)))

(defmacro get-name (symbol-or-string)
  (if (stringp symbol-or-string)
      symbol-or-string
    (string-downcase (symbol-name symbol-or-string))))

(defun reshape-array (old-array dims)
  (let ((result (make-array (to-list dims) 
			    :element-type (array-element-type old-array))))
    (over-column-major-indices (result cmi rmi)
      (setf (row-major-aref result cmi) (aref old-array rmi)))
    result))

(defun r-names (robj)  
  (let ((names (%rf-get-attrib robj *r-names-symbol*)))
    (unless (r-nil-p names)
      (convert-from-r names))))

(defun r-dims (robj)
  (let ((dims (%rf-get-attrib robj *r-dims-symbol*)))
    (unless (r-nil-p dims)
      (convert-from-r dims))))

;;; External 

(eval-when (:compile-toplevel :load-toplevel)
  (defmacro r (name &rest args)
    "The primary RCLG interface.  Backconverts the answer.  Name can
be a symbol or string.  Args are ordered or named (:named-arg)
arguments.  Examples:
  (r rnorm 100)
  (r plot #(1 3 2) #(3 2 5) :main \"silly plot\") 
." 
    (with-gensyms (evaled names dims result)
      `(let ((,evaled (r-call (get-name ,name) ,@args)))
	(let ((,result (convert-from-r ,evaled))
	      (,names (r-names ,evaled))
	      (,dims (r-dims ,evaled)))
	  (values (if ,dims (reshape-array ,result ,dims) 
		      ,result)
		  ,names))))))

(defmacro rnb (name &rest args)
  "Calls R, but returns the unevaled R object.  Protects it."
  `(make-instance 'sexp-holder
    :sexp (%rf-protect (r-call (get-name ,name) ,@args))
    :protected t))

(defmacro rnbi (name &rest args)
  "Calls R, returns the unevaled R object.  R object is protected, but
only until it's used in an R call.  Designed to be used internally to
R calls for 'anonymous' objects."
  `(make-instance 'sexp-holder
    :sexp (%rf-protect (r-call (get-name ,name) ,@args))
    :protected 'r-protect-until-used))

(defmacro rnr (name &rest args)
  "Calls R, but throws away the result and returns nothing.  Useful
for side effects such as plotting."
  `(progn
    (r-call (get-name ,name) ,@args)
    nil))

(defun unprotect-sexp (sexp-holder)
  (%rf-unprotect-ptr (slot-value sexp-holder 'sexp))
  (setf (slot-value sexp-holder 'protected) nil))
