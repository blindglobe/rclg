;;; RCLG: R-CommonLisp Gateway

;;; Copyright (c) --2006, rif@mit.edu.  All Rights Reserved.
;;; Author: rif@mit.edu
;;; Maintainers: rif@mit.edu, AJ Rossini <blindglobe@gmail.com>
;;; License:

;;; Intent: This code supports interaction between R's SEXPs and CL. 
;;; FIXME:AJR:  worth having a CLOSy style interface?

(defpackage :rclg-access
  (:use :common-lisp :cffi :rclg-types)
  (:export :r-setcar :r-car :r-cdr))

(in-package :rclg-access)

(defun r-get-union (sexp)
  "returns a component of an R SEXP."
  (foreign-slot-value sexp 'sexprec 'sxp-int-union))

(defun r-get-listsxp (sexp)
  "returns an R LIST SEXP."
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
