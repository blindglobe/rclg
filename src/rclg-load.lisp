;;; Copyright Rif 2006

;; test comment
(defpackage :rclg-load
  (:use :common-lisp :osicat :cffi)
  (:export :load-r-libraries :*rclg-loaded*))

(in-package :rclg-load)

(defvar *rclg-loaded* nil)
(defvar *r-home* #p"/home/rif/software/R-2.2.1/")

;; Set R_HOME environment variable
(setf (environment-variable "R_HOME") (namestring *r-home*))
      
;; Define and load foreign libraries
(define-foreign-library librclghelpers 
  (:unix (:or "librclghelpers.so.1.0"))
  (t (:default "librclghelpers")))

(define-foreign-library libR (t (:default "libR")))

(unless *rclg-loaded*
  (let ((*foreign-library-directories*
 	 (append (list #p"/home/rif/Projects/RCLG/c/"
 		       #p"/home/rif/software/R-2.2.1/lib/")
 		 *foreign-library-directories*)))
    (use-foreign-library libR)
    (use-foreign-library librclghelpers)
    (setf *rclg-loaded* t)))
