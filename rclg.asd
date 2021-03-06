;;;; -*- Mode: LISP; Syntax: ANSI-Common-Lisp; Base: 10 -*-

;;; FIXME:AJR: if needed.
;; (asdf:operate 'asdf:load-op 'cffi)

(defpackage rclg-system
  (:use :common-lisp :asdf))

(in-package :rclg-system)

(defsystem :rclg
  :description "RCLG: R to CL gateway"
  :version "2"
  :author "rif@mit.edu, blindglobe@gmail.com"
  :depends-on (:cffi) 
  :components
  ((:module src
	    :serial t
	    :components
	    ((:file "rclg-cffi-sysenv")
	     (:file "rclg-load"
		    :depends-on ("rclg-cffi-sysenv"))
	     (:file "rclg-types")
	     (:file "rclg-util")
	     (:file "rclg-foreigns"
		    :depends-on ("rclg-types"))
	     (:file "rclg-init"
		    :depends-on ("rclg-foreigns"))
	     (:file "rclg-access"
		    :depends-on ("rclg-types"))
	     (:file "rclg-convert"
		    :depends-on ("rclg-foreigns"))
	     (:file "rclg-control" 
		    :depends-on ("rclg-convert"
				 "rclg-foreigns"
				 "rclg-init"))
	     (:file "rclg-abstractions"
		    :depends-on ("rclg-util"
				 "rclg-control"))
	     (:file "rclg" 
		    :depends-on ("rclg-abstractions"
				 "rclg-access"
				 "rclg-convert"
				 "rclg-control"
				 "rclg-foreigns"
				 "rclg-init"
				 "rclg-load" ))))))
