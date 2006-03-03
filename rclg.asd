;;;; -*- Mode: LISP; Syntax: ANSI-Common-Lisp; Base: 10 -*-

;; Test comment.

(defsystem :rclg
    :version "0.1.0"
    :depends-on (:osicat :cffi)
    :components
    ((:module src
      :serial t
      :components
      ((:file "rclg-load")
       (:file "rclg-util")
       (:file "rclg-types")
       (:file "rclg-foreigns" :depends-on ("rclg-types"))
       (:file "rclg-init" :depends-on ("rclg-foreigns"))
       (:file "rclg-access" :depends-on ("rclg-types"))
       (:file "rclg-convert" :depends-on ("rclg-foreigns"))
       (:file "rclg-control" 
	      :depends-on ("rclg-convert" "rclg-foreigns" "rclg-init"))
       (:file "rclg-rcall"
	      :depends-on ("rclg-convert" "rclg-control"))
       ))))
