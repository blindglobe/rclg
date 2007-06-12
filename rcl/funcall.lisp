;; Copyright (c) 2006-2007 Carlos Ungil

;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
;; LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
;; OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

(in-package :rcl)

(defun r-variable (name)
  "Find the variable in the R image"
  (make-instance 'r-pointer 
		 :pointer (rf-findvar (rf-install name) *r-globalenv*)))

(defun r-function (name)
  "Find the function in the R image"
  (when (member (r-type-decode 
		 (first (sxpinfo-decode 
			 (sxpinfo-bitfield 
			  (sexp-sxpinfo 
			   (rf-findvar (rf-install name) *r-globalenv*))))))
		'(:promise :builtin-non-special-forms))
    (let ((result (rf-findfun (rf-install name) *r-globalenv*)))
      (when result (make-instance 'r-pointer :pointer result)))))
    
(defun r-funcall (function &rest args)
  "Call the function in the R image"
  (unless *r-session*
    (error "You have to execute (r-init) first"))
  (cffi:with-foreign-object (error-occurred :int)
    (let ((command (new-language-construct (1+ (count-if-not #'keywordp args))))
	  (r-function (r-function function)))
      (unless r-function (error "~A is not a valid function" function))
      (let ((list (sexp-union command)) cdr)
	(setf (listsxp-car list) (pointer r-function))
	(loop while args
	   do	(let ((arg (pop args)))
		  (setf cdr (listsxp-cdr list))
		  (setf list (sexp-union cdr))
		  ;; named argument passed as two successive arguments :name value
		  (when (keywordp arg)
		    (setf (listsxp-tag list)
			  (rf-install (string-downcase
				       (substitute #\_ #\- (symbol-name arg))))
			  arg (pop args)))
		  ;; named argument passed as cons (:name . value)
		  (when (and (consp arg) (keywordp (car arg)))
		    (setf (listsxp-tag list)
			  (rf-install (string-downcase
				       (substitute #\_ #\- (symbol-name (car arg)))))
			  arg (cdr arg)))
		  (setf (listsxp-car list) (r-obj-from-lisp arg)))))
      (let ((result (r-tryeval command *r-globalenv* error-occurred)))
	(if (zerop (cffi:mem-aref error-occurred :int))
	    (make-instance 'r-pointer :pointer result)
	    (error "error calling ~A" function))))))

