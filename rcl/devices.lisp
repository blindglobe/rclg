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

(defun device-details (type)
  "Returns for known types :ps, :pdf, :png, :jp[e]g, :xfig, :pictex 
a pair function,extension"
  (values-list (ecase type
		 (:ps '("postscript" "ps"))
		 (:pdf '("pdf" "pdf"))
		 (:png '("png" "png"))
		 ((or :jpeg :jpg) '("jpeg" "jpg"))
		 (:xfig '("xfig" "fig"))
		 (:pictex '("pictex" "tex")))))

(defmacro with-device ((filename type &rest options) &body body)
  "Executes the body after opening a graphical device that is closed at the end; 
options are passed to R (known types: :ps, :pdf, :png, :jp[e]g, :xfig, :pictex)"
  `(multiple-value-bind (device-name device-extension) (device-details ,type)
    (r% device-name (concatenate 'string ,filename "." device-extension) ,@options)
    (let ((device (r% "dev.cur")))
      (unwind-protect
	   (progn ,@body)
	(r% "dev.off" device)))))
