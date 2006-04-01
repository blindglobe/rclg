;;; RCLG: R-CommonLisp Gateway

;;; Copyright (c) --2006, rif@mit.edu.  All Rights Reserved.
;;; Author: rif@mit.edu
;;; Maintainers: rif@mit.edu, AJ Rossini <blindglobe@gmail.com>
;;; License: TBD

;;; Intent: This provides package definitions through rclg-user for
;;; rclg.

(defpackage :rclg
  (:use :common-lisp
	:rclg-access
	:rclg-control
	:rclg-convert
	:rclg-foreigns
	:rclg-init
	:rclg-load
	:rclg-types
	;; :uffi :rclg-load :common-idioms
	:rclg-load
	:rclg-util)
  (:export start-rclg r *r-started*
	   r-convert r-do-not-convert convert-to-r *backconvert* 
	   sexp sexp-not-needed
	   update-r def-r-call
	   *r-NA* r-na
	   r rnb))

(in-package :rclg)



;;; Bunch of old crap lives here.  FIXME:AJR: Bunch of old crap used to live
;;; here, but it's restricted to the function below this comment.
;;; More importantly, the above should be the definitions, etc.

(defun safe-unprotect (poss-sexp)
  "FIXME:AJR: This function is never used, but might be useful."
  (when (and (typep poss-sexp 'sexp-holder)
	     (slot-value poss-sexp 'protected))
    (%rf-unprotect-ptr (slot-value poss-sexp 'sexp))
    (setf (slot-value poss-sexp 'protected) nil))
  poss-sexp)


;;; User package for testing/evaluation.

(defpackage :rclg-user
  (:use :common-lisp
	:rclg))

;; FIXME:AJR: not needed if we are not planning on working in this
;; package.
;;(in-package :rclg-user)
