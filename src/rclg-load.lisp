;;; RCLG: R-CommonLisp Gateway

;;; Copyright (c) --2006, rif@mit.edu.  All Rights Reserved.
;;; Author: rif@mit.edu
;;; Maintainers: rif@mit.edu, AJ Rossini <blindglobe@gmail.com>

;;; Intent: initialize environment stuff.

(defpackage :rclg-load
  (:use :common-lisp :cffi :osicat)
  (:export :load-r-libraries :*rclg-loaded*))

(in-package :rclg-load)

(defvar *rclg-loaded* nil
  "True once rclg is loaded, nil while still loading.")
(defvar *r-home*
  ;; #p"/home/rif/software/R-2.2.1/"
  #p"/usr/lib/R"
  "This variable defines the r-home, need sto be configured by the
user, or done via discovery.")

(defvar *r-ld-library-additions*
  '(#p"/usr/lib/R/lib"
    #p":/usr/lib/R/library/grDevices/libs/"))

(concatenate 'string (mapcar #'namestring *r-ld-library-additions*))


;; Set R_HOME environment variable using OSICAT
(setf (environment-variable "R_HOME") (namestring *r-home*))

#+nil
(progn
  ;; Set Environmental Variables using CFFI
  (defcfun ("getenv" posix-getenv) :string
    (envname :string))
  
  (defcfun ("setenv" posix-setenv) :int
    (envname :string) (envval :string) (overwrite :int))
  
  ;; now initialize environment
  (posix-setenv "R_HOME" (namestring *r-home*) 1)

  ;; FIXME:AJR: yech.  This ought to be done properly, using paths
  ;; rather than strings.  And it's my fault.
  (posix-setenv "LD_LIBRARY_PATH"
		(concatenate 'string
			     (posix-getenv "LD_LIBRARY_PATH")
			     ":/usr/lib/R/lib"
			     ":/usr/lib/R/library/grDevices/libs/")
		1)
  #+nil(posix-setenv "R_SESSION_TEMPDIR" "/tmp/cls-scratch-0" 1) ; better default?
  )
  

;; Define and load foreign libraries
(define-foreign-library librclghelpers 
  (:unix (:or "librclghelpers.so.1.0"))
  (t (:default "librclghelpers")))

(define-foreign-library libR (t (:default "libR")))

;; FIXME:AJR: Configuration issue: Figure out libR location from
;; R_HOME, and the RCLG location, and insert.  This is a hack. 
;; Load only if not loaded, don't want to clobber dynloads.
(unless *rclg-loaded*
  (let ((*foreign-library-directories*
 	 (append (list #p"/home/rossini/public_html/CLS/CommonLispStat/CLS1.0A1.lisp/LispPackages/RCLG/c/"
		       #p"/usr/lib/R/lib/"
		       ;; #p"/home/rif/Projects/RCLG/c/"
 		       ;; #p"/home/rif/software/R-2.2.1/lib/"
		  )
 		 *foreign-library-directories*)))
    (use-foreign-library libR)
    ;;(use-foreign-library librclghelpers); put back in when we get it
					; compiled. 
    (setf *rclg-loaded* t)))
