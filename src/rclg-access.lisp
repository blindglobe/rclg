(defpackage :rclg-access
  (:use :common-lisp :cffi :rclg-types)
  (:export :r-setcar :r-car :r-cdr))

(in-package :rclg-access)

(defun r-get-union (sexp)
  (foreign-slot-value sexp 'sexprec 'sxp-int-union))

(defun r-get-listsxp (sexp)
  (foreign-slot-value 
   (r-get-union sexp) 
   'sexprec-internal-union 
   'listsxp))

(defun r-car (sexp)
  (foreign-slot-value (r-get-listsxp sexp) 'listsxp-struct 'carval))

(defun r-setcar (sexp value)
  (setf (foreign-slot-value (r-get-listsxp sexp) 'listsxp-struct 'carval)
	value))

(defun r-cdr (sexp)
  (foreign-slot-value (r-get-listsxp sexp) 'listsxp-struct 'cdrval))
