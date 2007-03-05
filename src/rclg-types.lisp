;;; RCLG: R-CommonLisp Gateway

;;; Copyright (c) 2005--2007, <rif@mit.edu>
;;;                           AJ Rossini <blindglobe@gmail.com>
;;; All rights reserved.
;;;
;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions are
;;; met:
;;;
;;;     * Redistributions of source code must retain the above copyright
;;;       notice, this list of conditions and the following disclaimer.
;;;     * Redistributions in binary form must reproduce the above
;;;       copyright notice, this list of conditions and the following disclaimer
;;;       in the documentation and/or other materials provided with the
;;;       distribution.
;;;     * The names of the contributors may not be used to endorse or
;;;       promote products derived from this software without specific
;;;       prior written permission.
;;;
;;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;;; "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;;; LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
;;; A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
;;; OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
;;; SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
;;; LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
;;; DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
;;; THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
;;; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
;;; OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

;;; Author:      rif@mit.edu
;;; Maintainers: rif@mit.edu,
;;;              AJ Rossini <blindglobe@gmail.com>

;;; Intent: Data structures in CommonLisp for representing R internal
;;; data structures.

(defpackage :rclg-types
  (:use :common-lisp :cffi)
  (:export :sexptype :sexp :sexp-elt-type :sexprec :sexp-holder
	   :listsxp-struct :listsxp
	   :cdrval :carval
	   :sxp-int-union :sexprec-internal-union
	   :r-string :r-complex :rl :im :protected :r-protect-until-used))

(in-package :rclg-types)

(eval-when (:compile-toplevel :load-toplevel)
  (defmacro def-typed-struct (struct-name type &rest field-names)
    `(defcstruct ,struct-name
       ,@(mapcar (lambda (n) `(,n ,type)) field-names)))
  
  (defmacro def-voidptr-struct (struct-name &rest field-names)
    "Define a structure in which all elements are of type pointer-to-void."
    `(def-typed-struct ,struct-name :pointer ,@field-names)))


;;; R types

;; Taken from Rinternals.h
;; We probably only need a few of these, but as soon as I needed two, I 
;; decided to go ahead and type them all in.
(defcenum sexptype 
  :nilsxp :symsxp :listsxp :closxp :envsxp :promsxp :langsxp
  :specialsxp :builtinsxp :charsxp 
  :lglsxp (:intsxp 13) :realsxp :cplxsxp :strsxp 
  :dotsxp :anysxp :vecsxp :exprsxp :bcodesxp 
  :extptrsxp :weakrefsxp (:funsxp 99))

(defun sexp-elt-type (sxp)
  (foreign-enum-value 'sexptype sxp))

;; bitfields
(defcstruct sxpinfo-struct (data :unsigned-int))

;; The structures in the union in the SEXPREC
(defcstruct primsxp-struct (offset :int))
(def-voidptr-struct symsxp-struct pname value internal)
(def-voidptr-struct listsxp-struct carval cdrval tagval)
(def-voidptr-struct envsxp-struct frame enclos hashtab)
(def-voidptr-struct closxp-struct formals body env)
(def-voidptr-struct promsxp-struct value expr env)

;; The real reason we need to specify these is to get the size of a
;; sexprec right.
(defcunion sexprec-internal-union
  (primsxp primsxp-struct)
  (symsxp symsxp-struct)
  (listsxp listsxp-struct)
  (envsxp envsxp-struct)
  (closxp closxp-struct)
  (promsxp promsxp-struct))

(defcstruct sexprec
  (sxpinfo sxpinfo-struct)
  (attrib :pointer)
  (gengcg-next-node :pointer)
  (gengcg-prev-node :pointer)
  (sxp-int-union sexprec-internal-union))

(defctype sexp :pointer)

;;; RCLG types

;;; FIXME:AJR:  Can we use a FFI call as an alternative to return the
;;; type?  It would be portable, but it would not be fast.  ARGH.
(defun sexptype (robj)
  "Gets the sexptype of an robj.
WARNING: ASSUMES THAT THE TYPE IS STORED IN THE LOW ORDER 5 BITS OF THE 
SXPINFO-STRUCT, AND THAT IT CAN BE EXTRACTED VIA A 'mod 32' OPERATION!
MAY NOT BE PORTABLE."
  (let ((info (foreign-slot-value
	       (foreign-slot-pointer robj 'sexprec 'sxpinfo)
	       'sxpinfo-struct 'data)))
    (mod info 32)))

(defclass sexp-holder () 
  ((sexp :initarg :sexp)
   (protected :initarg :protected :initform nil)))

(defmethod print-object ((s sexp-holder) stream)
  (format stream "#<sexp at 0x~16R, PROTECT=~A>" 
	  (pointer-address (slot-value s 'sexp))
	  (slot-value s 'protected)))

(defctype r-string :pointer)
(def-typed-struct r-complex :double rl im)
