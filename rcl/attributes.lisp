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

(defvar *print-attributes* nil
  "Print to standard output details about attributes when encountered")

(defvar *r-attributes-prefix* ";R. "
  "Default prefix used to print attributes")

(defun attributes-list (list)
  (unless (= (length list) 3)
    (error "the list doesn't have three elements"))
  (unless (typep (third list) 'r-symbol)
    (error "I expected a symbol, I got ~A" (third list)))
  (append (list (cons (intern (string-upcase (pname (third list))) "KEYWORD")
		      (first list)))
	  (if (second list) (attributes-list (second list)))))

(defun print-attributes (attributes)
  (let ((*print-pretty* nil))
    (format t 
	    (concatenate 'string "~{"  *r-attributes-prefix* "~S~&~}")
	    attributes)))
