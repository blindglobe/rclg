;;; RCLG: R-CommonLisp Gateway

;;; Copyright (c) --2006, rif@mit.edu.  All Rights Reserved.
;;; Author: rif@mit.edu
;;; Maintainers: rif@mit.edu, AJ Rossini <blindglobe@gmail.com>
;;; License: 

;;; Intent: This code provides access to libR functions and variables,
;;; wrapping them using CFFI.   Many of these should be exported to
;;; other packages, but no exported over to a naive user (only to
;;; developers and resulting code).

(defpackage :rclg-foreigns
  (:use :common-lisp :cffi :rclg-load :rclg-types)
  (:export :%set-tag :%rf-length :%set-vector-elt :%vector-elt
	   :%rf-elt :%rf-coerce-vector :%rf-alloc-vector
	   :%rf-protect :%rf-unprotect :%rf-unprotect-ptr
	   :%rf-init-embedded-r :%rf-find-var :%rf-find-fun
	   :%rf-install :%r-try-eval
	   :%rf-get-attrib :%rf-set-attrib
	   :%LOGICAL :%INT :%REAL :%COMPLEX 
	   :%rf-mkchar :%set-string-elt
	   :%string-elt :%r-char :%r-check-activity :%r-run-handlers
	   :*r-names-symbol* :*r-dims-symbol* :*r-global-env*
	   :*r-unbound-value* :*r-nil-value* :*r-input-handlers*
	   :%double-float-vec-to-R :%integer-vec-to-R))

(in-package :rclg-foreigns)

;; we can't do anything else until the R libraries are loaded.


(eval-when (:load-toplevel)
  (progn
    (load-r-libraries)
    (unless *rclg-loaded*
      (error "rclg-load has not loaded the R libraries."))))

;;; R library foreigns

(defcfun ("SET_TAG" %set-tag) :void
  (robj sexp)
  (tag sexp))

(defcfun ("Rf_length" %rf-length) :int
  (x sexp))

(defcfun ("SET_VECTOR_ELT" %set-vector-elt) sexp
  (x sexp)
  (i :int)
  (v sexp))

(defcfun ("VECTOR_ELT" %vector-elt) sexp
  (s sexp)
  (i :int))

(defcfun ("Rf_elt" %rf-elt) sexp
  (s sexp)
  (i :int))


(defcfun ("Rf_coerceVector" %rf-coerce-vector) sexp
  (s sexp)
  (type sexptype))


(defcfun ("Rf_allocVector" %rf-alloc-vector) sexp
  (s sexptype)
  (n :int))

;; FIXME:AJR: def-function doesn't take a docstring!  
;; The following "'Protects' the item (presumably by telling the
;; garbage collector it's in use, although I(rif) haven't looked at
;; the internals.  Returns the same pointer you give it.)"
(defcfun ("Rf_protect" %rf-protect) sexp
  (s sexp))

(defcfun ("Rf_unprotect" %rf-unprotect) :void
  (n :int))

(defcfun ("Rf_unprotect_ptr" %rf-unprotect-ptr) :void
  (s sexp))

;; Call this to initialize
(defcfun ("Rf_initEmbeddedR" %rf-init-embedded-r) :int
  (argc :int)
  (argv :pointer))


(defcfun ("Rf_findVar" %rf-find-var) sexp
  (installed sexp)
  (environment sexp))

(defcfun ("Rf_findFun" %rf-find-fun) sexp
  (installed sexp)
  (environment sexp))

(defcfun ("Rf_install" %rf-install) sexp
  (ident r-string))
  
(defcfun ("R_tryEval" %r-try-eval) sexp
  (e sexp)
  (env sexp)
  (error-occurred r-string))

(defcfun ("Rf_getAttrib" %rf-get-attrib) sexp
  (robj sexp)
  (attrib sexp))

(defcfun ("Rf_setAttrib" %rf-set-attrib) sexp
  (robj sexp)
  (attrib sexp)
  (val sexp))

(defcfun ("LOGICAL" %LOGICAL) :pointer (e sexp))
(defcfun ("INTEGER" %INT) :pointer (e sexp))
(defcfun ("REAL" %REAL) :pointer (e sexp))

(defcfun ("Rf_mkChar" %rf-mkchar) sexp
  (s r-string))

(defcfun ("SET_STRING_ELT" %set-string-elt) :void
  (robj sexp)
  (i :int)
  (string sexp))

(defcfun ("STRING_ELT" %string-elt) sexp
  (s sexp)
  (i :int))

(defcfun ("R_CHAR" %r-char) r-string
  (s sexp))

(defcfun ("R_checkActivity" %r-check-activity) :pointer
  (usec :int)
  (ignore-stdin :int))

(defcfun ("R_runHandlers" %r-run-handlers) :void
  (i :pointer)
  (f :pointer))

(defcfun ("COMPLEX" %COMPLEX) :pointer
  (e sexp))

;; libR foreign (global?) variables.

(eval-when (:compile-toplevel :load-toplevel)
  (defmacro def-r-var (r-name cl-name)
    `(defcvar (,r-name ,cl-name) sexp :read-only t)))

(def-r-var "R_NamesSymbol" *r-names-symbol*)
(def-r-var "R_DimSymbol" *r-dims-symbol*)
(def-r-var "R_GlobalEnv" *r-global-env*)
(def-r-var "R_UnboundValue" *r-unbound-value*)
(def-r-var "R_NilValue" *r-nil-value*)
(def-r-var "R_InputHandlers" *r-input-handlers*)

;;; data to R conversion functions -- found in ../c/rclg-helpers.c
;; will only work if shared libraries are loaded.

#+nil
(defcfun ("doubleFloatVecToR" %double-float-vec-to-R) :void
  (d :pointer)
  (i :int)
  (s sexp))

#+nil
(defcfun ("intVecToR" %integer-vec-to-R) :void
  (d :pointer)
  (i :int)
  (s sexp)
  (div :int))
