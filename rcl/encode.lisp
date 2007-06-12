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

(defun r-obj-from-lisp (thing)
  (etypecase thing
    (r-pointer (pointer thing))
    (boolean (r-obj-from-lisp (vector thing)))
    (number (r-obj-from-lisp (vector thing)))
    (string (new-string-single thing))
    ((or list vector)
     (cond ((every (lambda (x) (typep x 'boolean)) thing)
	    (let ((result (new-logical (length thing))))
	      (set-data-integers result (map 'vector (lambda (x) (if x 1 0)) thing))
	      result))
	   ((every #'r-obj-p thing)
	    (let ((result (new-real (length thing)))) 
	      ;; FIXME, this is completely wrong
	      ;; from the rpy example I'm trying to convert to an R object
	      ;; a list of (0.01231d0), each element is a uni-element vector
	      ;; the line below handles that very specific case
	      (set-data-sexps result (mapcar (lambda (x) (first (get-data-sexps x))) thing))
	      result))
	   ((every #'integerp thing)
	    (let ((result (new-integer (length thing))))
	      (set-data-integers result thing)
	      result))
	   ((every #'numberp thing)
	    (let ((result (new-real (length thing))))
	      (set-data-reals result thing)
	      result))
	   ((every #'stringp thing)
	    (let ((result (new-string (length thing))))
	      (set-data-strings result thing)
	      result))
	   (t (error "Don't know how to translate to R: ~A" thing))))))

