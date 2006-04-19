;;; RCLG: R-CommonLisp Gateway

;;; Copyright (c) --2006, rif@mit.edu.  All Rights Reserved.
;;; Author: rif@mit.edu
;;; Maintainers: rif@mit.edu, AJ Rossini <blindglobe@gmail.com>

;;; Intent: initialize environment stuff.  Purely developer level, no
;;; user tools.

;(asdf:oos 'asdf:load-op 'cffi)
;(asdf:oos 'asdf:load-op 'rclg)
;(load "rclg-cffi-sysenv")
;(use-package :cffi)
;(use-package :rclg-cffi-sysenv)

(defpackage :rclg-load
  (:use :common-lisp :cffi :rclg-cffi-sysenv);  :osicat)
  (:export load-r-libraries *rclg-loaded*))

(in-package :rclg-load)

;;;* Variables for RCLG state/location

(defvar *rclg-loaded* nil
  "True once rclg is loaded, nil otherwise (including errors).")

;; The next one is important so that we do the right thing for any
;; helper acceleration libraries (which was originally what rif
;; wanted.  The other is more to "do the right thing", at least
;; eventually.
;; (setf (logical-pathname-translations "rclgsrc")
;;       '(("**;*.*.*"
;; 	 "/home/rossini/public_html/CLS/CommonLispStat/CLS1.0A1.lisp/LispPackages/RCLG.svn/**/")))
;; ;; FIXME:AJR: Need to verify this incantation
;; (setf (logical-pathname-translations "rhomedir")
;;       '(("**;*.*.*"
;; 	 "/opt/R-2-3-patches/lib/R/lib/**/")))

(defvar *R-HOME-STR* 
  ;;  "/opt/R-2-2-patches/lib/R" ;; root is /opt/R-2-2-patches/
  "/opt/R-2-3-patches/lib/R" ;; root is /opt/R-2-3-patches/
  ;;  "/opt/rdevel/lib/R"        ;; root is /opt/rdevel/
  ;;  "/usr/lib/R/"             ;; root is /usr/
  )
; *R-HOME-STR*

(defvar *R-CORE-LIB-DIRS* (list (concatenate 'string *R-HOME-STR* "/lib")
				(concatenate 'string *R-HOME-STR* "/library/grDevices/libs/")))

; *R-CORE-LIB-DIRS*

(posix-setenv "R_HOME" *R-HOME-STR* 1)

(defun load-r-libraries () 
  (unless *rclg-loaded*
    (progn
      
      (add-new-cffi-lib-directory *R-CORE-LIB-DIRS*)
      ;;(posix-getenv "LD_LIBRARY_PATH") ; validation of "right thing"
      
      (defvar libr-location  (concatenate 'string *R-HOME-STR* "/lib/" "libR"))
      ;libr-location
      ;(stringp libr-location)

      ;; I don't understand why I have to use explicit strings and paths?
      (define-foreign-library libR (t (:default "/opt/R-2-3-patches/lib/R/lib/libR")))
      ;;(define-foreign-library libR (t (:default "libR")))
      (use-foreign-library libR)
      
      (define-foreign-library grDevices (t (:default "/opt/R-2-3-patches/lib/R/library/grDevices/libs/grDevices")))
      ;;(define-foreign-library grDevices (t (:default "grDevices")))

      ;; the following complains that it can't load libR, though we've already loaded it.  Sigh...
      #+nil(use-foreign-library grDevices)
      
      (setf *rclg-loaded* t))))

  
  ;; *rclg-loaded*
