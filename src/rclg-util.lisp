;;; RCLG: R-CommonLisp Gateway

;;; Copyright (c) --2006, rif@mit.edu.  All Rights Reserved.
;;; Author: rif@mit.edu
;;; Maintainers: rif@mit.edu, AJ Rossini <blindglobe@gmail.com>
;;; License:

;;; Intent: utility macros and functions.
;;;

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
