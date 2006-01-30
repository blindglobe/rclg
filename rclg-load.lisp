;;; Copyright Rif 2004

(defpackage :rclg-load
  (:use :common-lisp :sb-alien :osicat)
  (:export :load-r-libraries :*rclg-loaded*))

(in-package :rclg-load)

(defvar *rclg-loaded* nil)
(defvar *r-home* #p"/home/rif/software/R-2.2.1/")

(eval-when (:load-toplevel :execute)
  (unless *rclg-loaded*
    (setf (environment-variable "R_HOME") (namestring *r-home*)
	  *rclg-loaded*
	  
	  (and (load-shared-object 
		(namestring (merge-pathnames #p"lib/libR.so" *r-home*)))
	       (load-shared-object 
		"/home/rif/Projects/RCLG/librclghelpers.so.1.0")))))

;; 	  (and (load-foreign-library 
;; 		"/usr/lib/R/lib/libR.so" 
;; 		:module "R"
;; 		:supporting-libraries '("-lc" "-lgpm" "-lncurses" "-ldl" 
;; 					"-lreadline" "-lgcc_s" "-lm"
;; 					"-lg2c" "-lblas"))
;; 	       (load-foreign-library "/home/rif/Projects/RCLG/rclg-helpers.o")))))
