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

(defmacro new-language-construct (n)
  `(rf-allocvector langsxp ,n))

(defmacro new-integer (n)
  `(rf-allocvector intsxp ,n))

(defmacro new-real (n)
  `(rf-allocvector realsxp ,n))

(defmacro new-complex (n)
  `(rf-allocvector cplxsxp ,n))

(defmacro new-list (n)
  `(rf-allocvector vecsxp ,n))

(defmacro new-logical (n)
  `(rf-allocvector lglsxp ,n))

(defmacro new-character (n)
  `(rf-allocvector strsxp ,n))

(defmacro new-string (n)
  `(rf-allocvector strsxp ,n))

(defmacro new-string-single (string)
  `(rf-mkstring ,string))

(defmacro new-internal-char (string)
  `(rf-mkchar ,string))

(defmacro sexp-attrib (sexp)
  `(cffi:foreign-slot-value ,sexp 'SEXPREC 'attrib))

(defmacro sexp-union (sexp)
  `(cffi:foreign-slot-value ,sexp 'SEXPREC 'u))

(defmacro sexp-vecsxp (sexp)
  `(cffi:foreign-slot-value ,sexp 'VECTOR_SEXPREC 'vecsxp))

(defmacro sexp-sxpinfo (sexp)
  `(cffi:foreign-slot-value ,sexp 'SEXPREC 'sxpinfo))

(defmacro sxpinfo-bitfield (sxpinfo)
  `(cffi:foreign-slot-value ,sxpinfo 'sxpinfo_struct 'bitfield))

(defmacro vecsxp-length (vecsxp)
  `(cffi:foreign-slot-value ,vecsxp 'vecsxp_struct 'length))

(defmacro vecsxp-true-length (vecsxp)
  `(cffi:foreign-slot-value ,vecsxp 'vecsxp_struct 'truelength))

(defmacro listsxp-car (listsxp)
  `(cffi:foreign-slot-value ,listsxp 'listsxp_struct 'carval))

(defmacro listsxp-cdr (listsxp)
  `(cffi:foreign-slot-value ,listsxp 'listsxp_struct 'cdrval))

(defmacro listsxp-tag (listsxp)
  `(cffi:foreign-slot-value ,listsxp 'listsxp_struct 'tagval))

;; #define TAG(e)		((e)->u.listsxp.tagval)

(defmacro symsxp-pname (symsxp)
    `(cffi:foreign-slot-value ,symsxp 'symsxp_struct 'pname))

(defmacro symsxp-value (symsxp)
    `(cffi:foreign-slot-value ,symsxp 'symsxp_struct 'value))

(defmacro symsxp-internal (symsxp)
    `(cffi:foreign-slot-value ,symsxp 'symsxp_struct 'internal))