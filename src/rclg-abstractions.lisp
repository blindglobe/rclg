;;; RCLG: R-CommonLisp Gateway

;;; Copyright (c) --2006, rif@mit.edu.  All Rights Reserved.
;;; Author: rif@mit.edu
;;; Maintainers: rif@mit.edu, AJ Rossini <blindglobe@gmail.com>
;;; License:

;;; Intent: higher level abstractions on top of RCLG.

(defpackage :rclg-abstractions
  (:use :common-lisp :rclg-control :rclg-util)
  (:export :def-r-call))

(in-package :rclg-abstractions)

(defun remove-keys-from-plist (plist keys)
  "Returns a copy of plist with keys removed.  For re-using the &REST arg after
removing some options."
  (when plist
    (append (unless (member (car plist) keys) (subseq plist 0 2))
	    (remove-keys-from-plist (cddr plist) keys))))
  
(defun to-keyword (symbol)
  (intern (symbol-name symbol) :keyword))

(defun atom-or-first (val)
  (if (atom val) val (car val)))

(defmacro def-r-call ((function-name r-name conversion &rest required-args) 
		      &rest keyword-args)
  "Utility macro for defining calls to R.  Defines a CL function
function-name that calls the R function r-name.  The conversion
argument specifices what happens to the result: :convert converts the
result to CL, :raw yields an unconverted R sexp, and :no-result throws
away the results (for side effects only).  The keyword args allow
specification of default values, others keys are allowed.  For example,

  (def-r-call (r-hist hist :no-result sequence) main xlab (breaks 50)
              (probability t) (col \"blue\"))

creates a CL function r-hist that calls the R function hist on a
sequence, returning no results.  The keywords :main and :xlab are
passed with default values nil, and the other keywords are passed with
the chosen values.  (Try (r-hist (rnb rnorm 1000)), for instance.)
"
  (let* ((keyword-names (mapcar #'atom-or-first keyword-args))
	 (keywords (mapcar #'to-keyword keyword-names))
	 (rest-sym (gensym)))
    `(defun ,function-name (,@required-args 
			 &rest ,rest-sym 
			 &key ,@keyword-args
			 &allow-other-keys)
      (,(case conversion
	      (:convert 'r)
	      (:raw 'rnb)
	      (:no-result 'rnr))
       ,r-name 
       ,@required-args
       ,@(mapcan #'(lambda (k n) (list k n)) 
		 keywords 
		 keyword-names)
       (remove-keys-from-plist ,rest-sym ',keywords)))))
