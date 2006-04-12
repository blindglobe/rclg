;;; RCLG: R-CommonLisp Gateway

;;; Copyright (c) --2006, rif@mit.edu.  All Rights Reserved.
;;; Author: rif@mit.edu
;;; Maintainers: rif@mit.edu, AJ Rossini <blindglobe@gmail.com>

;;; Intent: initialize environment stuff.  Purely developer level, no
;;; user tools.

(asdf:oos 'asdf:load-op 'cffi)

(defpackage :rclg-load
  (:use :common-lisp :cffi :rclg-cffi-sysenv);  :osicat)
  (:export load-r-libraries *rclg-loaded*))

(in-package :rclg-load)

;;;* Variables for RCLG state/location

(defvar *rclg-loaded* nil
  "True once rclg is loaded, nil otherwise (including errors).")

(defvar RCLG-home-string
  "/home/rossini/public_html/CLS/CommonLispStat/CLS1.0A1.lisp/LispPackages/RCLG.svn"
  "String containing RCLG directory.  Should be auto-found.")

;;;* Variables for R_HOME and other R-centric libraries/initialization

(defvar R-HOME-string "/opt/rdevel/lib/R"
  "String containing R_HOME (root installation directory).
Needs to be configured by the user, or self-discovered.  See R docs
for more details.")

(defvar *r-home* (pathname r-home-string)
  ;; #p"/home/rif/software/R-2.2.1/"
  "Pathname for *r-home*.")

(defvar r-ld-library-additions-root-string (list "/lib" "/library/grDevices/libs/")
  "Strings containing paths to libraries to put on LD_LIBRARY_PATH for loading, relative to R_HOME.")

;(defvar r-ld-library-additions-string
; (concatenate 'string  R-HOME-string  r-ld-library-additions-root-string)
;  "Strings containing paths to libraries to put on LD_LIBRARY_PATH for loading.")


;(defvar *r-ld-library-additions*
;  '((pathname (concatenate 'string R-HOME-string "/lib"))
;    (pathname (
;    #p"/usr/lib/R/library/grDevices/libs/"))
;  (mapcar #'pathname (concatenate 'string
;				  (mapcar #'namestring r-ld-library-additions-string)
;				  #p"/opt/rdevel/lib/R/lib"
;    #p"/opt/rdevel/lib/R/library/grDevices/libs/")))

;; FIXME:AJR: (AJR needs more lisp-fu):
;; ERROR - these are paths, not strings!
;; (concatenate 'string (mapcar #'namestring *r-ld-library-additions*))

;; Set R_HOME environment variable using OSICAT
;;(setf (environment-variable "R_HOME") (namestring *r-home*))
;; FIXME:AJR: OSICAT + CFFI broken on recent SBCL's.


;; now initialize environment
(posix-setenv "R_HOME" (namestring *r-home*) 1)

;; FIXME:AJR: yech.  This ought to be done properly, using paths
;; rather than strings.  And it's my fault.
#+nil(posix-setenv "LD_LIBRARY_PATH"
	      (concatenate 'string
			   (posix-getenv "LD_LIBRARY_PATH")
			   ":/usr/lib/R/lib"
			   ":/usr/lib/R/library/grDevices/libs/"
			   ":/home/rossini/public_html/CLS/CommonLispStat/CLS1.0A1.lisp/LispPackages/RCLG.svn/c/")
	      1)
#+nil(posix-setenv "R_SESSION_TEMPDIR" "/tmp/cls-scratch-0" 1) ; better default?

  
#+nil(progn 
  ;; Define and load foreign libraries
  (define-foreign-library librclghelpers 
    (:unix (:or "librclghelpers.so.1.0"))
    (t (:default "librclghelpers")))
  
  ;;(define-foreign-library libR (t (:default "libR")))
  ;;(define-foreign-library libRg (t (:default "grDevices")))
  
  ;;(define-foreign-library libR (t (:default "/usr/lib/R/lib/libR")))
  ;;(define-foreign-library libRg (t (:default "/usr/lib/R/library/grDevices/libs/grDevices")))
  
  ;;(define-foreign-library libR (t (:default "/opt/rdevel/lib/R/lib/libR")))
  ;;(define-foreign-library libRg (t (:default "/opt/rdevel/lib/R/library/grDevices/libs/grDevices")))
  
  (define-foreign-library libR (t (:default "/opt/R-2-2-patches/lib/R/lib/libR")))
  (define-foreign-library libRg (t (:default "/opt/R-2-2-patches/lib/R/library/grDevices/libs/grDevices")))
  
  ;;(define-foreign-library libR (t (:default "/opt/R-2-3-patches/lib/R/lib/libR")))
  ;;(define-foreign-library libRg (t (:default "/opt/R-2-3-patches/lib/R/library/grDevices/libs/grDevices")))
  
  ;; FIXME:AJR: Configuration issue: Figure out libR location from
  ;; R_HOME, and the RCLG location, and insert.  This is a hack. 
  ;; Load only if not loaded, don't want to clobber dynloads.
  #+nil
  (unless *rclg-loaded*
    (let ((*foreign-library-directories*
	   (append (list #p"/home/rossini/public_html/CLS/CommonLispStat/CLS1.0A1.lisp/LispPackages/RCLG.svn/c/"
			 ;; #p"/opt/rdevel/lib/R/lib/"
			 ;; #p"/opt/rdevel/lib/R/library/grDevices/libs/"
			 #p"/opt/R-2-2-patches/lib/R/lib"
			 #p"/opt/R-2-2-patches/lib/R/library/grDevices/libs/"
			 ;; #p"/usr/lib/R/lib/"
			 ;; #p"/usr/lib/R/library/grDevices/libs/"
			 ;; #p"/home/rif/Projects/RCLG/c/"
			 ;; #p"/home/rif/software/R-2.2.1/lib/"
			 )
		   *foreign-library-directories*)))
      (use-foreign-library libR)
      #+nil(use-foreign-library libRg)
      ;;(use-foreign-library librclghelpers); put back in when we get it
					; compiled. 
      (setf *rclg-loaded* t)))
  )

;;; Alternative approach -- but it barfs.
(progn 
  (posix-setenv "R_HOME" "/opt/R-2-3-patches/lib/R" 1)

  (posix-setenv "LD_LIBRARY_PATH"
		(concatenate 'string
			     ;; Default Debian
			     ;;"/usr/lib/R/lib:"
			     ;;"/usr/lib/R/library/grDevices/libs/:"
			     ;; Verify, --prefix=/opt/rdevel
			     "/opt/R-2-3-patches/lib:"
			     "/opt/R-2-3-patches/lib/R/library/grDevices/libs/:"
			     (posix-getenv "LD_LIBRARY_PATH"))
		1)

  (pushnew #P"/opt/R-2-3-patches/lib/R/lib/"
           ;; #P"/usr/lib/R/lib/"
	   *foreign-library-directories*
	   :test #'equal)

  (pushnew #P"/opt/R-2-3-patches/lib/R/library/grDevices/libs/"
	   ;; #P"/usr/lib/R/library/grDevices/libs/"
	   *foreign-library-directories*
	   :test #'equal)

  (define-foreign-library libR (t (:default "libR")))

  (use-foreign-library libR)

  (define-foreign-library grDevices
    (t (:default "grDevices")))

  #+nil(use-foreign-library grDevices)

  (setf *rclg-loaded* t))


;; *rclg-loaded*
