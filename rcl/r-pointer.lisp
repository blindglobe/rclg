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

(defclass r-pointer ()
  ((pointer :initarg :pointer :accessor pointer)))

;;  clisp    ffi:foreign-address 
;;  cmu      sys:system-area-pointer
;;  openmcl  ccl:macptr
;;  sbcl     sb-sys:system-area-pointer
;;  allegro  integer

(defun r-obj-p (thing)
  (typep thing 'r-pointer))

(defgeneric r-obj-decode (sexp))

(defgeneric r-obj-describe (sexp))
  
(defmethod r-obj-decode ((sexp r-pointer))
  (r-obj-decode (pointer sexp)))

(defmethod r-obj-describe ((sexp r-pointer))
  (r-obj-describe (pointer sexp)))

(defmethod print-object ((r-pointer r-pointer) stream)
  (print-unreadable-object (r-pointer stream :type t :identity t)
    (format stream "~s ~s" (r-obj-describe r-pointer) (pointer r-pointer))))
