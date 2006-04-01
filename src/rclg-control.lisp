;;; RCLG: R-CommonLisp Gateway

;;; Copyright (c) --2006, rif@mit.edu.  All Rights Reserved.
;;; Author: rif@mit.edu
;;; Maintainers: rif@mit.edu, AJ Rossini <blindglobe@gmail.com>

;;; Intent: primary evaluation tool for R code; return values are R SEXPs. 

(defpackage :rclg-control
  (:use :common-lisp :cffi :rclg-types :rclg-foreigns :rclg-access
	:rclg-init :rclg-convert :rclg-util)
  (:export r rnb))

(in-package :rclg-control)

;;; Internal

(defun rname-to-robj (name)
  "If R has a mapping for name (name is a string), returns the SEXP
that points to it, otherwise returns NIL."
  (with-foreign-string (ident-foreign name)
    (let ((foreign-value
	   (%rf-find-var (%rf-install ident-foreign) *r-global-env*)))
      (if (r-bound foreign-value)
	  foreign-value
	  nil))))

(defun rname-to-rfun (name)
  "If R has a mapping for name (name is a string), returns the SEXP
that points to it, otherwise returns NIL."
  (and (rname-to-robj name)
       (with-foreign-string (ident-foreign name)
	 (let ((foreign-value
		(%rf-find-fun (%rf-install ident-foreign) *r-global-env*)))
	   (if (r-bound foreign-value)
	       foreign-value
	       nil)))))

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

(defun get-r-error ()
  ;;FIXME:AJR:  what does geterrmessage reference to?
  (r geterrmessage))

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
      (setf exp (r-cdr exp)))))

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
    (unless (r-nil names)
      (convert-from-r names))))

(defun r-dims (robj)
  (let ((dims (%rf-get-attrib robj *r-dims-symbol*)))
    (unless (r-nil dims)
      (convert-from-r dims))))

;;; External 

(eval-when (:compile-toplevel :load-toplevel)
  (defmacro r (name &rest args)
    "The primary RCLG interface.  Backconverts the answer.  Name can
be a symbol or string.  VERIFY:AJR: args are function arguments."  
    (with-gensyms (evaled names dims result)
      `(let ((,evaled (r-call (get-name ,name) ,@args)))
	(let ((,result (convert-from-r ,evaled))
	      (,names (r-names ,evaled))
	      (,dims (r-dims ,evaled)))
	  (values (if ,dims (reshape-array ,result ,dims) 
		      ,result)
		  ,names))))))

(defmacro rnb (name &rest args)
  "Calls R, but returns the unevaled R object.  Doesn't protect it."
  `(make-instance 'sexp-holder :sexp (r-call (get-name ,name) ,@args)))
