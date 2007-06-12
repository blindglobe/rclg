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

(defvar *extract-single-element* t
  "If a list contains a single element, return the element instead")

(defun r-type-decode (n)
  (cdr (assoc n *r-types*)))

(defun r-type (sexp)
  (let ((sxpinfo (sxpinfo-decode (sxpinfo-bitfield (sexp-sxpinfo sexp)))))
    (r-type-decode (first sxpinfo))))

;; the first version worked on PPC, but not on Intel
;; ppc:  671088768   #b 00101 0 00 0000000000000000 1 0 0 0 0 000
;; intel: 16777221   #b 000 0 0 0 0 1 0000000000000000 00 0 00101
;; there is something wrong with openmcl
;;       134217728   #b 00001000 00000000 00000000 00000000 
;; (ldb version of sxpinfo-decode by Alexey Goldin)

#+cffi-features:ppc32
(defun sxpinfo-decode (int)
  (let ((type  (ldb (byte 5 27) int))
	(obj   (ldb (byte 1 26) int))
	(named (ldb (byte 2 24) int)) 
	(gp    (ldb (byte 16 8) int))
	(mark  (ldb (byte 1 7) int))
	(debug (ldb (byte 1 6) int))
	(trace (ldb (byte 1 5) int))
	(fin   (ldb (byte 1 4) int))
	(gcgen (ldb (byte 1 3) int)) 
	(gccls (ldb (byte 3 0) int)))
    (list type obj named gp mark debug trace fin gcgen gccls)))

#-cffi-features:ppc32
(defun sxpinfo-decode (int)
  (let ((type  (ldb (byte 5 0) int))
	(obj   (ldb (byte 1 5) int))
	(named (ldb (byte 2 6) int)) 
	(gp    (ldb (byte 16 8) int))
	(mark  (ldb (byte 1 24) int))
	(debug (ldb (byte 1 25) int))
	(trace (ldb (byte 1 26) int))
	(fin   (ldb (byte 1 27) int))
	(gcgen (ldb (byte 1 28) int)) 
	(gccls (ldb (byte 3 29) int)))
    (list type obj named gp mark debug trace fin gcgen gccls)))
 
(defmethod r-obj-describe (sexp)
  (let ((sxpinfo (sxpinfo-decode (sxpinfo-bitfield (sexp-sxpinfo sexp)))))
    (let ((type (r-type-decode (first sxpinfo))))
      (if (member type *r-vector-types*)
	  (let ((vecsxp (sexp-vecsxp sexp)))
	    (list type (vecsxp-length vecsxp) (vecsxp-true-length vecsxp)))
	  type))))

(defmethod r-obj-decode (sexp)
  (let ((attributes (unless (eq :null (r-type (sexp-attrib sexp)))
		      (attributes-list (r-obj-decode (sexp-attrib sexp)))))
	(result
	 (case (r-type sexp)
	   (:symbol
	    (let ((list (sexp-union sexp)))
	      (make-instance 'r-symbol 
			    :name (r-obj-decode (symsxp-pname list))
			    :value (r-obj-decode (symsxp-value list))
			    :internal (r-obj-decode (symsxp-internal list)))))
	   (:list-of-dotted-pairs
	    (let ((list (sexp-union sexp)))
	      (mapcar #'r-obj-decode
		      (list (listsxp-car list) (listsxp-cdr list) (listsxp-tag list)))))
	   (:null nil)
	   (:scalar-string-type (cffi:foreign-string-to-lisp (cffi:inc-pointer sexp 24)))
	   (:generic-vector (mapcar #'r-obj-decode (get-data-sexps sexp)))
	   (:logical-vector (mapcar #'plusp (get-data-integers sexp)))
	   (:string-vector (get-data-strings sexp))
	   (:real-vector (get-data-reals sexp))
	   (:integer-vector (get-data-integers sexp))
	   (t (list :unknown (r-type sexp))))))
    (when (and attributes (not (equal :list-of-dotted-pairs (r-type (sexp-attrib sexp)))))
      (error "I was expecting the type of the attributes to be :list-of-dotted-pairs, but I got ~A" (r-type (sexp-attrib sexp))))
    (when (and *print-attributes* attributes)
      (print-attributes attributes))
    (when (and *extract-single-element* (listp result) (car result) (not (cdr result)))
      (setf result (car result)))
    (if attributes 
	(values result attributes)
      result)))