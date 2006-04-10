
(in-package :cl-user)

(defpackage #:gcc-xml-ffi (:use #:cl)
	    (:export
	     #:parse-gcc-xml-file
	     #:write-uffi-declarations
	     #:with-foreign-signed-string
	     #:convert-to-foreign-string
	     #:convert-to-foreign-signed-string
	     ))

(in-package :gcc-xml-ffi)

(defparameter *gccxml-executable* "gccxml")

