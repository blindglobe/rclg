;;; RCLG: R-CommonLisp Gateway

;;; Copyright (c) 2005--2007, <rif@mit.edu>
;;;                           AJ Rossini <blindglobe@gmail.com>
;;; All rights reserved.
;;;
;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions are
;;; met:
;;;
;;;     * Redistributions of source code must retain the above copyright
;;;       notice, this list of conditions and the following disclaimer.
;;;     * Redistributions in binary form must reproduce the above
;;;       copyright notice, this list of conditions and the following disclaimer
;;;       in the documentation and/or other materials provided with the
;;;       distribution.
;;;     * The names of the contributors may not be used to endorse or
;;;       promote products derived from this software without specific
;;;       prior written permission.
;;;
;;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;;; "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;;; LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
;;; A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
;;; OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
;;; SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
;;; LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
;;; DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
;;; THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
;;; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
;;; OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

;;; Author:      rif@mit.edu
;;; Maintainers: rif@mit.edu,
;;;              AJ Rossini <blindglobe@gmail.com>

;;; Intent: utility macros and functions.

(defpackage :rclg-util
  (:use :common-lisp)
  (:export :with-gensyms  
	   :over-column-major-indices 
	   :to-list :to-vector)) 

(in-package :rclg-util)

;;; Export:

(defmacro with-gensyms (syms &body body)
  `(let (,@(mapcar (lambda (sy)
		     `(,sy (gensym ,(symbol-name sy))))
		   syms))
    ,@body))

(defun to-list (seq)
  (map 'list #'identity seq))

(defun to-vector (seq)
  (map 'vector #'identity seq))

(defmacro over-column-major-indices ((array cmi rmi) &body body)
  (with-gensyms (n index dims update-index dim d index-param)
    `(let* ((,n (array-total-size ,array))
	    (,dims (to-vector (array-dimensions ,array)))
	    (,d (array-rank ,array))
	    (,index (to-list (make-array ,d :initial-element 0))))
       (labels ((,update-index (,index-param ,dim)
		   (incf (car ,index-param))
		   (when (= (car ,index-param) (aref ,dims ,dim))
		     (setf (car ,index-param) 0)
		     (when (< ,dim (- ,d 1))
		       (,update-index (cdr ,index-param) (+ ,dim 1))))))
	 (dotimes (,rmi ,n)
	   (let ((,cmi (apply #'array-row-major-index ,array ,index)))
	     ,@body
	     (,update-index ,index 0)))))))
