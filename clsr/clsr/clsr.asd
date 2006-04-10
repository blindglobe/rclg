
(asdf:oos 'asdf:load-op 'ch-asdf)

(defpackage #:clsr-system (:use #:asdf #:cl #:ch-asdf))
(in-package #:clsr-system)

#+darwin
(progn
  (defparameter *r-dir* "/bobo/Library/Frameworks/R.framework/Resources/")
  (defparameter *r-lib-dir* (concatenate 'string *r-dir* "lib/"))
  (defparameter *r-include-dir* (concatenate 'string *r-dir* "include/")))

#+(and (not darwin) x86-64)
(progn
  (defparameter *r-dir* "/usr/local/lib64/R/")
  (defparameter *r-lib-dir* (concatenate 'string *r-dir* "lib/"))
  (defparameter *r-include-dir* (concatenate 'string *r-dir* "include/")))

#+(and (not darwin) (not x86-64))
(progn
  (defparameter *r-dir* "/usr/local/lib/R/")
  (defparameter *r-lib-dir* (concatenate 'string *r-dir* "lib/"))
  (defparameter *r-include-dir* (concatenate 'string *r-dir* "include/")))


(defparameter *link-library-directories*
  (list *r-lib-dir*))

(defparameter *link-libraries*
  (list "R"))

(defclass clsr-gcc-xml-c-source-file (gcc-xml-c-source-file) ())

(defmethod include-directories ((c clsr-gcc-xml-c-source-file))
  (list *r-include-dir*
        (asdf:component-pathname
         (asdf:find-component
          (asdf:find-system "clsr")
          "include"))))

(defmethod link-library-directories ((c clsr-gcc-xml-c-source-file))
  *link-library-directories*)

(defmethod link-libraries ((c clsr-gcc-xml-c-source-file))
  *link-libraries*)

(defclass r-source-file (static-file) ())

(defsystem :clsr
  :name "clsr"
  :author "Cyrus Harmon"
  :version "0.1.1-20060315"
  :licence "BSD"
  :depends-on (:xmls :uffi :gcc-xml-ffi :ch-util)
  :components
  ((:module
    :include :pathname #p"include/"
    :components ((:static-file "clsr-lib-include" :pathname #.(make-pathname :name "clsr-lib" :type "h"))))
   (:unix-dso "c-src"
              :dso-name "libclsr"
              :dso-directory #p"../lib/"
              :include-directories (#p"include/" #.*r-include-dir*)
              :components ((:c-source-file "clsr-lib"))
              :link-library-directories #.*link-library-directories*
              :link-libraries #.*link-libraries*)
   (:module
    :clsr-gccxml-source
    :pathname #p"gccxml-src/"
    :components
    ((:clsr-gcc-xml-c-source-file "clsr-for-gccxml"
                                  :pathname #p"clsr-for-gccxml.c"
                                  :xml-output-file-path #p"clsr.xml")))
   (:static-file "clsr-xml" :pathname #p"gccxml-src/clsr.xml"
                 :depends-on (:clsr-gccxml-source :include))
   (:module
    :src
    :components
    ((:ch-cl-source-file "defpackage")
     (:ch-cl-source-file "clsr-loader" :depends-on ("defpackage"))
     (:gcc-xml-xml-file "clsr-xml-file"
                        :pathname #p"../gccxml-src/clsr.xml"
                        :output-file-path #p"clsr-sb-alien-decls.cl"
                        :dest-package :r
                        :depends-on ("defpackage" "clsr-loader"))
     (:gcc-xml-cl-source-file "clsr-sb-alien-decls"
                              :pathname "../gccxml-src/clsr-sb-alien-decls.cl"
                              :depends-on ("clsr-xml-file"))
     (:ch-cl-source-file "clsr"
                         :depends-on ("defpackage" "clsr-loader" "clsr-sb-alien-decls"))
     (:ch-cl-source-file "clsr-parse-eval"
                         :depends-on ("defpackage" "clsr"))
     (:ch-cl-source-file "clsr-objects"
                         :depends-on ("defpackage" "clsr"))
     (:ch-cl-source-file "clsr-sxp"
                         :depends-on ("defpackage" "clsr" "clsr-parse-eval" "clsr-objects"))
     (:ch-cl-source-file "clsr-rref"
                         :depends-on ("defpackage" "clsr" "clsr-parse-eval" "clsr-sxp")))
    :depends-on ("clsr-gccxml-source" "c-src" "clsr-xml"))
   (:static-file "README")
   (:static-file "COPYRIGHT")
   (:module
    :r-src :pathname #p"R/"
    :components
    ((:r-source-file "lisp" :pathname #p"lisp.R")))))

