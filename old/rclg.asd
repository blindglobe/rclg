;;;; -*- Mode: LISP; Syntax: ANSI-Common-Lisp; Base: 10 -*-

(defsystem :rclg
    :version "0.1.0"
    :depends-on (:middleangle.cl.utilities :osicat
		 :uffi)
    :components
    ((:file "rclg-load")
     (:file "rclg" :depends-on ("rclg-load"))))

     ;; (:file "rclg-util" :depends-on ("rclg"))))
