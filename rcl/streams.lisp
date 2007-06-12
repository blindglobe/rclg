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

(defvar *r-output* t
  "Default stream where R output will be sent if captured")

(defvar *r-message* t
  "Default stream where R messages will be sent if captured")

(defvar *r-output-prefix* ";R# "
  "Default prefix used to print lines of R output")
(defvar *r-message-prefix* ";R! "
  "Default prefix used to print lines of R messages")

(defmacro with-r-output ((&optional stream prefix) &body body)
  "Capture R output and send it to stream (default *r-output*),
adding a prefix to each line (default *r-output-prefix*)"
  (let ((sink (gensym "SINK-OUT"))
	(result (gensym "RESULT")))
  `(let ((,sink (r-funcall "textConnection" "tmpout" "w"))
	 ,result)
     (r-funcall "sink" :file ,sink :type "output")
     (unwind-protect
	  (setf ,result (progn ,@body))
       (r-funcall "sink" :type "output")
       (r-funcall "close" ,sink)
       (format ,(or stream '*r-output*) 
	       (concatenate 'string "~{"  ,(or prefix '*r-output-prefix*) "~A~&~}")
	       (let ((*extract-single-element* nil))
		 (r-obj-decode (r-variable "tmpout")))))
     ,result)))
  
(defmacro with-r-message ((&optional (stream *r-message*) (prefix *r-message-prefix*)) &body body)
  "Capture R messages and send them to stream (default *r-message*),
adding a prefix to each line (default *r-message-prefix*)"  
  (let ((sink (gensym "SINK-ERR"))
	(result (gensym "RESULT")))
  `(let ((,sink (r-funcall "textConnection" "tmperr" "w"))
	 ,result)
     (r-funcall "sink" :file ,sink :type "message")
     (unwind-protect
	  (setf ,result (progn ,@body))
       (r-funcall "sink" :type "message")
       (r-funcall "close" ,sink)
       (format ,stream (concatenate 'string "~{"  ,prefix "~A~&~}")
	       (let ((*extract-single-element* nil))
		 (r-obj-decode (r-variable "tmperr")))))
     ,result)))

(defmacro with-r-streams (() &body body)
  `(let ((sink-out (r-funcall "textConnection" "tmpout" "w"))
	 (sink-err (r-funcall "textConnection" "tmperr" "w"))
	 result)
     (r-funcall "sink" :file sink-out :type "output")
     (r-funcall "sink" :file sink-err :type "message")
     (unwind-protect
	  (setf result (progn ,@body))
       (r-funcall "closeAllConnections")
;; I had to resort to closing all connections
;; there were issues with the more granular approach below
;;        (r-funcall "sink" :type "output")
;;        (r-funcall "sink" :type "message")
;;        (r-funcall "close.connection" sink-out)
;;        (r-funcall "close.connection" sink-err)
       (format *r-output* 
	       (concatenate 'string "~{"  *r-output-prefix* "~A~&~}")
	       (let ((*extract-single-element* nil))
		 (r-obj-decode (r-variable "tmpout"))))
       (format *r-message* (concatenate 'string "~{"  *r-message-prefix* "~A~&~}")
	       (let ((*extract-single-element* nil))
		 (r-obj-decode (r-variable "tmperr")))))
     result))
  

