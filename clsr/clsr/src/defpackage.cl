
(in-package :cl-user)

(defpackage #:clsr
  (:use #:cl)
  (:export :object-registry
	   :register-object
	   :unregister-id))
     

(defpackage #:r)
;;  (:use #:cl)
;; (:shadow :trace :debug :cadddr :caddr :cddr :cadr :cdar :caar :cdr :car :complex :real :integer))
