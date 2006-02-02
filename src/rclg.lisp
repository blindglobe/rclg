;;; Bunch of old crap lives here.

(defpackage "RCLG"
  (:use :common-lisp :uffi :rclg-load )
	;; :common-idioms)
  (:export :start-r :rclg :r :sexp :*backconvert* :*r-started*
	   :r-convert :r-do-not-convert :convert-to-r
	   :sexp-not-needed :update-r :def-r-call :*r-NA* :r-na))

(in-package :rclg)

(defun safe-unprotect (poss-sexp)
  (when (and (typep poss-sexp 'sexp-holder)
	     (slot-value poss-sexp 'protected))
    (%rf-unprotect-ptr (slot-value poss-sexp 'sexp))
    (setf (slot-value poss-sexp 'protected) nil))
  poss-sexp)

