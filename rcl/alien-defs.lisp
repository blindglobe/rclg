;; Copyright (c) 2006 Carlos Ungil

;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
;; LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
;; OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

(in-package :rcl)

(cffi:defctype SEXP :pointer)

;;  :type  5  :obj   1  :named 2  :gp    16  :mark 1
;;  :debug 1  :trace 1  :fin   1  :gcgen  1  :gccls 3
(cffi:defcstruct sxpinfo_struct
    (bitfield :unsigned-int))

(cffi:defcstruct primsxp_struct
  (offset :int))

(cffi:defcstruct symsxp_struct
  (pname :pointer)
  (value :pointer)
  (internal :pointer))

(cffi:defcstruct listsxp_struct
  (carval :pointer)
  (cdrval :pointer)
  (tagval :pointer))

(cffi:defcstruct envsxp_struct
  (frame :pointer)
  (enclos :pointer)
  (hashtab :pointer))

(cffi:defcstruct closxp_struct
  (formals :pointer)
  (body :pointer)
  (env :pointer))

(cffi:defcstruct promsxp_struct
  (value :pointer)
  (expr :pointer)
  (env :pointer))

(cffi:defcunion SEXPREC_UNION
 (primsxp primsxp_struct)
 (symsxp symsxp_struct)
 (listsxp listsxp_struct)
 (envsxp envsxp_struct)
 (closxp closxp_struct)
 (promsxp promsxp_struct))

(cffi:defcstruct SEXPREC
  (sxpinfo sxpinfo_struct)
  (attrib :pointer)
  (gengc_next_node :pointer)
  (gengc_prev_node :pointer)
  (u SEXPREC_UNION))

(cffi:defcstruct vecsxp_struct
  (length :int)
  (truelength :int))

(cffi:defcstruct VECTOR_SEXPREC
  (sxpinfo sxpinfo_struct)
  (attrib :pointer)
  (gengc_next_node :pointer)
  (gengc_prev_node :pointer)
  (vecsxp vecsxp_struct))

(cffi:defcunion SEXPREC_ALIGN
  (s VECTOR_SEXPREC)
  (align :double))

(cffi:defcvar "R_GlobalEnv" SEXP)

(cffi:defcfun "Rf_initEmbeddedR" :int (argc :int) (argv :pointer))
(cffi:defcfun "Rf_install" SEXP (str :string))
(cffi:defcfun "Rf_findFun" SEXP (fun SEXP) (rho SEXP))
(cffi:defcfun "Rf_findVar" SEXP (var SEXP) (rho SEXP))
(cffi:defcfun "Rf_eval" SEXP (expr SEXP) (rho SEXP))
(cffi:defcfun "R_tryEval" SEXP (expr SEXP) (rho SEXP) (error :pointer))

(cffi:defcfun "Rf_allocVector" SEXP (type :unsigned-int) (length :int))
(cffi:defcfun "Rf_mkChar" SEXP (string :string))
(cffi:defcfun "Rf_mkString" SEXP (string :string))

