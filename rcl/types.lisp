;; Copyright (c) 2006-2007 Carlos Ungil

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

(defvar NILSXP	0	  "nil = NULL")
(defvar SYMSXP	1	  "symbols")
(defvar LISTSXP 2	  "lists of dotted pairs")
(defvar CLOSXP 3	  "closures")
(defvar ENVSXP 4	  "environments")
(defvar PROMSXP 5	  "promises: [un]evaluated closure arguments")
(defvar LANGSXP 6	  "language constructs (special lists)")
(defvar SPECIALSXP 7	  "special forms")
(defvar BUILTINSXP 8	  "builtin non-special forms")
(defvar CHARSXP 9	  "\"scalar\" string type (internal only)")
(defvar LGLSXP 10	  "logical vectors")
(defvar INTSXP 13	  "integer vectors")
(defvar REALSXP 14	  "real variables")
(defvar CPLXSXP 15	  "complex variables")
(defvar STRSXP 16	  "string vectors")
(defvar DOTSXP 17	  "dot-dot-dot object")
(defvar ANYSXP 18	  "make \"any\" args work. Used in s)pecifying types for symbol registration to m)ean anything is okay")
(defvar VECSXP 19	  "generic vectors")
(defvar EXPRSXP 20	  "expressions vectors")
(defvar BCODESXP 21       "byte code")
(defvar EXTPTRSXP 22      "external pointer")
(defvar WEAKREFSXP 23     "weak reference")
(defvar RAWSXP 24         "raw bytes")

(defvar FUNSXP 99         "Closure or Builtin")

(defvar *r-vector-types* '(:real-vector :integer-vector :complex-vector :string-vector
       			 :logical-vector :generic-vector :expressions-vector))

(defvar *r-types* `((,NILSXP . :null)
		    (,SYMSXP . :symbol)
		    (,LISTSXP . :list-of-dotted-pairs)
		    (,CLOSXP . :closure)
		    (,ENVSXP . :environments)
		    (,PROMSXP . :promise)
		    (,LANGSXP . :language-construct)
		    (,SPECIALSXP . :special-form)
		    (,BUILTINSXP . :builtin-non-special-forms)
		    (,CHARSXP . :scalar-string-type)
		    (,LGLSXP . :logical-vector)
		    (,INTSXP . :integer-vector)
		    (,REALSXP . :real-vector)
		    (,CPLXSXP . :complex-vector)
		    (,STRSXP . :string-vector)
		    (,DOTSXP . :dot-dot-dot)
		    (,ANYSXP . :any)
		    (,VECSXP . :generic-vector)
		    (,EXPRSXP . :expressions-vector)
		    (,BCODESXP . :byte-code)
		    (,EXTPTRSXP . :external-pointer)
		    (,WEAKREFSXP . :weak-reference)
		    (,RAWSXP . :raw-bytes)
		    (,FUNSXP . :closure-or-builtin)))
