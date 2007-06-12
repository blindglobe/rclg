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

;; with-r-streams is more robust, but closes all the existing connections

(defun r%-parse-eval (string)
  "Parse and evaluate the string in the R environment (returns r-pointer)"
  ;;(with-r-message () (with-r-output () (r-funcall "eval" (r-funcall "parse" :text string)))))
  (with-r-streams () (r-funcall "eval" (r-funcall "parse" :text string))))

(defun r-parse-eval (string)
  "Call r%-parse-eval and decode the result"
  (r-obj-decode (r%-parse-eval string)))

(defun r% (&rest args)
  "Apply the first argument to rest in the R environment (returns r-pointer)"
  ;;(with-r-message () (with-r-output () (apply #'r-funcall args))))
  (with-r-streams () (apply #'r-funcall args)))

(defun r (&rest args)
  "Call r% and decode the result"
  (r-obj-decode (apply #'r% args)))

(defun r%-values (&rest args)
  "Like r%, but returning output and messages as additional value"
  (let ((output (make-string-output-stream))
	(message (make-string-output-stream)))
     (values (with-r-message (message "") 
	       (with-r-output (output "") 
		 (apply #'r-funcall args)))
	     (get-output-stream-string output)
	     (get-output-stream-string message))))

;;FIXME this won't work if decoding produces values!
(defun r-values (&rest args)
  "Call r%-values and decode the principal value"
  (let ((output (make-string-output-stream))
	(message (make-string-output-stream)))
    (values (r-obj-decode (with-r-message (message "") 
			    (with-r-output (output "") 
			      (apply #'r-funcall args))))
	     (get-output-stream-string output)
	     (get-output-stream-string message))))


