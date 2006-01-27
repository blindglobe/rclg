;;; Copyright Rif 2004

(defpackage "RCLG-LOAD"
  (:use :common-lisp :uffi)
  (:export :load-r-libraries :*rclg-loaded*))

(in-package :rclg-load)

(defvar *rclg-loaded* nil)

(eval-when (:load-toplevel :execute)
  (unless *rclg-loaded*
    (setf *rclg-loaded*
	  (and (load-foreign-library 
		"/usr/local/src/r-base-1.9.1/bin/libR.so" 
		:module "R"
		:supporting-libraries '("-lc" "-lgpm" "-lncurses" "-ldl" 
					"-lreadline" "-lgcc_s" "-lm"
					"-lg2c" "-lblas"))
	       (load-foreign-library "/home/rif/Projects/RCLG/rclg-helpers.o")))))
