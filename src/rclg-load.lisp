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

;; The user MUST make sure *R-HOME-STR* points to the right place!  --rif
;; Need to fix this by flagging RIF or TONY or someone else.

;;; This should be fixed.
(eval-when (:compile-toplevel :load-toplevel)
  (defvar *R-HOME-STR* 
    ;;"/home/rif/RCLG-test/R-2.3.1"
    "/home/rif/rclg-test/R-2.3.1"
    ;;"/usr/lib/R"             ;; root is /usr/
    ;;"/opt/R-2-2-patches/lib/R" ;; root is /opt/R-2-2-patches/
    ;;"/opt/R-2-3-patches/lib/R" ;; root is /opt/R-2-3-patches/
    ;;"/opt/rdevel/lib/R"        ;; root is /opt/rdevel/
    ))

;; (setf *R-HOME-STR*   "/usr/lib/R")
;; *R-HOME-STR*

(defvar *R-CORE-LIB-DIRS*
  (list (concatenate 'string *R-HOME-STR* "/lib")
	(concatenate 'string *R-HOME-STR* "/library/grDevices/libs/")))

;; (setf *R-CORE-LIB-DIRS*
;;        (list (concatenate 'string *R-HOME-STR* "/lib")
;;              (concatenate 'string *R-HOME-STR* "/library/grDevices/libs/")))
;; *R-CORE-LIB-DIRS*

(posix-setenv "R_HOME" *R-HOME-STR* 1)

(defun load-r-libraries () 
  (unless *rclg-loaded*
    (progn
      (define-foreign-library libR
	  (t (:default #.(concatenate 'string *R-HOME-STR* "/lib/libR"))))
      (use-foreign-library libR)
      (setf *rclg-loaded* t))))

;; *rclg-loaded*
