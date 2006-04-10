
(in-package :gcc-xml-test)

(defun eval-decls (s)
  (loop for d = (read s nil)
     while d do
       (format t "~A~%" d)
       (eval d)))

(defparameter *library-path*
  (asdf:component-pathname
   (asdf:find-component
    (asdf:find-system "gcc-xml-ffi-test")
    "libraries")))

(defun uffi-load-library (lib)
  (unless (uffi:load-foreign-library 
	   (uffi:find-foreign-library
	    lib
	    (list (pathname-directory *load-truename*)
		  (print (merge-pathnames 
			  (make-pathname :directory (list :relative "libffitest" ".libs"))
                          *library-path*
			  ))
		  (print (merge-pathnames 
			  (make-pathname :directory (list :relative "lib" "ffitest"))
                          *library-path*
			  )))
	    :types '("so" "dylib"))
	   :supporting-libraries '("c")
	   :module lib
	   :force-load t)
    (error "Unable to load ffitest library")))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defparameter *ffitest-loaded* nil)

  (when *load-truename*
    (uffi-load-library "libffitest"))
  (let ((decls))
    (with-open-file (defout "decls.lisp" :direction :output :if-exists :supersede)
      (setf decls (parse-gcc-xml-file "test/ffitest.xml"))
      (write-uffi-declarations decls defout))
    (with-open-file (defin "decls.lisp" :direction :input)
      (let ((*package* (find-package :gcc-xml-test)))
	(eval-decls defin)))
    (setf *ffitest-loaded* t)
    decls))

(defun do-test2 ()
  (let ((x (uffi::convert-to-foreign-string "evenboguser")))
    (let ((foreign-string-y (|foo_function| x)))
      (let ((y (uffi::convert-from-foreign-string foreign-string-y)))
        (print y))
      (uffi:free-foreign-object foreign-string-y))
    (uffi:free-foreign-object x)))

(defun do-uffi-test-2 ()
  (when *load-truename*
      (uffi-load-library "libffitest"))
  (let ((decls))
    (with-open-file (defout "decls.lisp" :direction :output :if-exists :supersede)
      (setf decls (parse-gcc-xml-file "test/ffitest2.xml"))
      (write-uffi-declarations decls defout)
      )
;    (defpackage #:opengl (:use #:cl))
;    (let ((*package* (find-package :opengl)))
    (let ((*package* (find-package :gcc-xml-test)))
      (with-open-file (defin "decls.lisp" :direction :input)
	(eval-decls defin))
      )
    decls))

