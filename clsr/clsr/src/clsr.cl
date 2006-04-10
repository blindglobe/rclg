;; -*- mode: lisp -*-

;;; (c) 2005--2006, Cyrus Harmon, all rights reserved.
;;; Author: Cyrus Harmon
;;; Maintainers: Cyrus Harmon and AJ Rossini

;;; Purpose: main code, package status/initialization

(in-package :clsr)

(define-condition r-error (error)
  ((details :reader r-error-details :initarg :details :initform "Unknown error"))
  (:report (lambda (condition stream)
             (format stream "Error in R: ~A" (r-error-details condition)))))

(defparameter *r-home* clsr-system::*r-dir*
  "The directory where R (include, lib, etc...) is installed")

;;; Use defvar so that these doesn't get reset to nil if we reload
;;; this file!
(defvar *r-initialized* nil
  "Flag to indicate whether or not R has been initialized. R doesn't
  like to be initialized zero or more than one times. So use this to
  let us know when clsr-init is mistakenly called twice.")

;;; HACK-ALERT!!!
;;; define an alien-variable that isn't in the headers that allows us
;;; to ignore the new stack checking stuff

(sb-alien:define-alien-variable ("R_CStackLimit" r::|R_CStackLimit|) sb-alien:unsigned-long) 

(defun minus-one-as-unsigned-long (bits)
  (ldb (byte (1- bits) 0) -1))

;;; In theory, we could be calling clsr-init automatically at load
;;; time, but we're not, for the moment.
;;; This function must be called before any other R functions are
;;; called.
(defun clsr-init ()
  (unless *r-initialized*
    (let* ((argc 1)
           (argv (sb-alien:make-alien (* sb-alien:char) argc)))
      (unwind-protect
           (progn
             (gcc-xml-ffi::with-alien-signed-string (clsr-string "CLSR")
               (setf (sb-alien:deref argv 1)
                     clsr-string)

	       #+darwin
	       (gcc-xml-ffi::with-alien-signed-string (env (format nil "R_HOME=~A" *r-home*))
                 (sb-posix::putenv env))

	       #-darwin
	       (sb-posix::putenv (format nil "R_HOME=~A" *r-home*))
	       
               (print (sb-posix::getenv "R_HOME"))
	       (sb-ext::with-float-traps-masked (:divide-by-zero :invalid)
		 (r::|Rf_initialize_R| argc argv)
		 (setf r::|R_CStackLimit|
		       (minus-one-as-unsigned-long
			(sb-alien:alien-size sb-alien:unsigned-long)))
		 (r::|setup_Rmainloop|))))
        (when argv (sb-alien:free-alien argv))))
    (setf *r-initialized* t)))


(defun load-clsr-r-source-files ()
  (let ((r-src-component
         (asdf:find-component
          (asdf:find-system "clsr")
          "r-src")))
    (let ((r-src-files (asdf:module-components r-src-component)))
      (mapcar #'asdf:component-pathname r-src-files))))
  
;;;; declare some R types to make it a bit easier to put type
;;;; declarations in other functions

;;; SEXP -- (* struct SEXPREC)
(deftype r-sexp ()
  "alien R SEXP type (pointer to SEXPREC)"
  '(sb-alien:alien (sb-alien:* (SB-ALIEN:STRUCT R::|SEXPREC|))))

;;; Rcomplex
(deftype r-complex ()
  "alien R complex number struct type"
  '(sb-alien:alien r::|Rcomplex|))

