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

(defun get-data-integers (sexp)
  (let ((start-data (cffi:inc-pointer sexp 24))
	(length (vecsxp-length (sexp-vecsxp sexp))))
    (loop for i from 0 below length
       collect (cffi:mem-aref start-data :int i))))

(defun set-data-integers (sexp integers)
  (let ((start-data (cffi:inc-pointer sexp 24)))
    (dotimes (i (length integers))
      (setf (cffi:mem-aref start-data :int i) (coerce (elt integers i) 'integer)))))

(defun get-data-reals (sexp)
  (let ((start-data (cffi:inc-pointer sexp 24))
	(length (vecsxp-length (sexp-vecsxp sexp))))
    (loop for i from 0 below length
       collect (cffi:mem-aref start-data :double i))))

(defun set-data-reals (sexp reals)
  (let ((start-data (cffi:inc-pointer sexp 24)))
    (dotimes (i (length reals))
      (setf (cffi:mem-aref start-data :double i) (coerce (elt reals i) 'double-float)))))

(defun get-data-sexps (sexp)
  (let ((start-data (cffi:inc-pointer sexp 24))
	(length (vecsxp-length (sexp-vecsxp sexp))))
    (loop for i from 0 below length
       collect (cffi:mem-aref start-data :pointer i))))

(defun set-data-sexps (sexp pointers)
  (let ((start-data (cffi:inc-pointer sexp 24)))
    (dotimes (i (length pointers))
      (setf (cffi:mem-aref start-data :pointer i) (elt pointers i)))))

(defun get-data-strings (sexp)
  (let ((start-data (cffi:inc-pointer sexp 24))
	(length (vecsxp-length (sexp-vecsxp sexp))))
    (loop for i from 0 below length
       collect (r-obj-decode (cffi:mem-aref start-data :pointer i)))))

(defun set-data-strings (sexp strings)
  (let ((start-data (cffi:inc-pointer sexp 24)))
    (dotimes (i (length strings))
      (setf (cffi:mem-aref start-data :pointer i)
	    (new-internal-char (elt strings i))))))

