
(defpackage #:gcc-xml-ffi-system (:use #:asdf #:cl))
(in-package #:gcc-xml-ffi-system)

;;;;
;;;; The following section customizes asdf to work with filenames
;;;; with a .cl extension and to put fasl files in a separate
;;;; directory.
;;;;
;;;; To enable this behvior, use asdf component type
;;;;  :gcc-xml-ffi-cl-source-file
;;;;
(defclass gcc-xml-ffi-cl-source-file (cl-source-file) ())

(defparameter *fasl-directory*
  (make-pathname :directory '(:relative
			      #+sbcl "sbcl-fasl"
			      #+openmcl "openmcl-fasl"
			      #-(or sbcl openmcl) "fasl")))

(defmethod source-file-type ((c gcc-xml-ffi-cl-source-file) (s module)) "cl")

(defmethod asdf::output-files :around ((operation compile-op) (c gcc-xml-ffi-cl-source-file))
  (list (merge-pathnames *fasl-directory* (compile-file-pathname (component-pathname c)))))


(defsystem :gcc-xml-ffi
    :name "gcc-xml-ffi"
    :author "Cyrus Harmon"
    :version "0.1.4-20060315"
    :depends-on (:xmls :uffi)
    :components
    ((:module
      :src
      :components
      ((:gcc-xml-ffi-cl-source-file "defpackage")
       (:gcc-xml-ffi-cl-source-file "gcc-xml-util"
				    :depends-on ("defpackage"))
       (:gcc-xml-ffi-cl-source-file "gcc-xml-classes"
				    :depends-on ("defpackage" "gcc-xml-util"))
       (:gcc-xml-ffi-cl-source-file "gcc-xml-parse"
				    :depends-on ("defpackage" "gcc-xml-util" "gcc-xml-classes"))
       (:gcc-xml-ffi-cl-source-file "gcc-xml-uffi"
				    :depends-on ("defpackage" "gcc-xml-util" "gcc-xml-classes"))
       (:gcc-xml-ffi-cl-source-file "gcc-xml-sb-alien"
				    :depends-on ("defpackage" "gcc-xml-util" "gcc-xml-classes"))))
     (:static-file "README")
     (:static-file "TODO")
     (:static-file "LICENSE")
     (:static-file "Makefile")
     (:static-file "ChangeLog")))

