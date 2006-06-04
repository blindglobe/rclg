;;;; -*- Mode: LISP; Syntax: ANSI-Common-Lisp; Base: 10 -*-

;;; FIXME:AJR: if needed.
;; (asdf:operate 'asdf:load-op 'cffi)

;; RIF: Removed :cffi from :use'd packages here
(defpackage rclg-system
  (:use :common-lisp :asdf)) ; :osicat))

(in-package :rclg-system)

(defsystem :rclg
  :description "RCLG: R to CL gateway"
  :version "0.1.0"
    :author "rif@mit.edu, blindglobe@gmail.com"
    :depends-on (:cffi) ; :osicat)
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
;;       (:file "rclg-rcall"
;;	      :depends-on ("rclg-convert" "rclg-control"))
       (:file "rclg" 
	      :depends-on ("rclg-access"
			   "rclg-convert"
			   "rclg-control"
			   "rclg-foreigns"
			   "rclg-init"
			   "rclg-load" ))))))
