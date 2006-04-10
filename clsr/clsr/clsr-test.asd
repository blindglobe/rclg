
(defpackage #:clsr-test-system (:use #:asdf #:cl))
(in-package #:clsr-test-system)

;;;;
;;;; The following section customizes asdf to work with filenames
;;;; with a .cl extension and to put fasl files in a separate
;;;; directory.
;;;;
;;;; To enable this behvior, use asdf component type
;;;;  :clsr-cl-source-file
;;;;
(defclass clsr-test-cl-source-file (cl-source-file) ())

(defmethod source-file-type ((c clsr-test-cl-source-file) (s module)) "cl")

(defparameter *fasl-directory*
  (make-pathname :directory '(:relative #+sbcl "sbcl-fasl"
			      #+openmcl "openmcl-fasl"
			      #-(or sbcl openmcl) "fasl")))

(defmethod asdf::output-files ((operation compile-op) (c clsr-test-cl-source-file))
  (list (merge-pathnames *fasl-directory*
			 (compile-file-pathname (component-pathname c)))))

(defsystem :clsr-test
  :name "clsr-test"
  :author "Cyrus Harmon"
  :version "0.1.1-20060315"
  :licence "BSD"
  :depends-on (:gcc-xml-ffi :clsr :clem) ;; :ch-image :ch-imageio)
  :components
  ((:module
    :test
    :components
    ((:clsr-test-cl-source-file "defpackage")
     (:clsr-test-cl-source-file "test-clsr"
                                :depends-on ("defpackage"))))
   (:module
    :lib :pathname "clsr-test")))
