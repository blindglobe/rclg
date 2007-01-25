;;; RCLG: R-CommonLisp Gateway

;;; Copyright (c) --2006, rif@mit.edu.  All Rights Reserved.
;;; Author: rif@mit.edu
;;; Maintainers: rif@mit.edu, AJ Rossini <blindglobe@gmail.com>

;;; Intent: initialize environment stuff.  Purely developer level, no
;;; user tools.

(defpackage :rclg-load
  (:use :common-lisp :cffi :rclg-cffi-sysenv)
  (:export load-r-libraries *rclg-loaded*))

(in-package :rclg-load)

;;;* Variables for RCLG state/location

(defvar *rclg-loaded* nil
  "True once rclg is loaded, nil otherwise (including errors).")


;; The user MUST make sure *R-HOME-STR* points to the right place!
;; --rif 

;; AJR: we do this by testing directories existence.  Rif's is first,
;; Debian's is second.  A better way to do this would be to check that
;; the library exists, but we could do that later if we don't need 

(eval-when (:compile-toplevel :load-toplevel)
  (defvar *R-HOME-STR* 
    (namestring
     (cond
       ((probe-file #p"/home/rif/RCLG-test/R-2.3.1"))
       ((probe-file #p"/usr/lib/R"))
       (t (error "R not found."))))))

(posix-setenv "R_HOME" *R-HOME-STR* 1)

(defun load-r-libraries () 
  (unless *rclg-loaded*
    (progn
      (define-foreign-library libR
	  (t (:default #.(concatenate 'string *R-HOME-STR* "/lib/libR"))))
      (use-foreign-library libR)
      (setf *rclg-loaded* t))))

;; *rclg-loaded*
