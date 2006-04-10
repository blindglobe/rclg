
(defpackage #:gcc-xml-ffi-test-system (:use #:asdf #:cl))
(in-package #:gcc-xml-ffi-test-system)

;;;;
;;;; The following section customizes asdf to work with filenames
;;;; with a .cl extension and to put fasl files in a separate
;;;; directory.
;;;;
;;;; To enable this behvior, use asdf component type
;;;;  :gcc-xml-ffi-test-cl-source-file
;;;;
(defclass gcc-xml-ffi-test-cl-source-file (cl-source-file) ())

(defmethod source-file-type ((c gcc-xml-ffi-test-cl-source-file) (s module)) "cl")

(defparameter *fasl-directory*
  (make-pathname :directory '(:relative #+sbcl "sbcl-fasl"
			      #+openmcl "openmcl-fasl"
			      #-(or sbcl openmcl) "fasl")))

(defmethod asdf::output-files ((operation compile-op) (c gcc-xml-ffi-test-cl-source-file))
  (list (merge-pathnames *fasl-directory*
			 (compile-file-pathname (component-pathname c)))))

(defsystem :gcc-xml-ffi-test
    :name "gcc-xml-ffi-test"
    :author "Cyrus Harmon"
    :version "0.1.4-20060315"
    :depends-on (:xmls :uffi :gcc-xml-ffi)
    :components
    ((:module
      :test
      :components
      ((:gcc-xml-ffi-test-cl-source-file "defpackage")
       (:gcc-xml-ffi-test-cl-source-file "gcc-xml-test"
					 :depends-on ("defpackage"))))
     (:module
      :libraries :pathname "")))

