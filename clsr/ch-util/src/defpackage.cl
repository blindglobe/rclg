
(in-package #:cl-user)

(defpackage #:ch-util
  (:use #:cl #:asdf)
  (:export #:get-fasl-directory

	   #:insert-before
	   #:insert-before-all
	   #:closest-common-ancestor

	   #:subclassp

	   #:strcat
	   #:trim
           
           #:str-to-int
           #:int-to-str
           
           #:get-current-date

	   #:double-float-divide
	   #:single-float-divide
	   
	   #:defun-export
	   #:defparameter-export
	   #:defclass-export
	   #:defmethod-export

	   #:postincf
	   #:array-sum

	   #:interncase
	   #:make-intern
	   #:make-keyword
	   #:keyword-list-names
	   #:byte-buffer
	   #:read-file-to-buffer
	   #:print-buffer
	   #:make-test-run
	   #:test-run-tests
	   #:test-run-passed
	   #:run-test

           #:pathname-as-directory
	   #:pwd
	   #:ls
	   #:with-open-file-preserving-case
           
           #:prefix
           #:subdirectories
           #:list-directory

           #:unix-name

	   #:make-dist
	   #:unregister-system

	   #:run-program
	   #:process-output-stream

           #:make-hash-table-from-plist
           #:make-hash-table-from-alist
           
           #:map-vector
	   
	   #:pdf-open
	   #:html-open

	   ))

