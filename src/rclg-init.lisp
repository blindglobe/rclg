(defpackage :rclg-init
  (:use :common-lisp :rclg-foreigns :cffi)
  (:export :start-rclg))

(in-package :rclg-init)

(defvar *r-default-argv* '("rclg" "-q" "--vanilla"))
(defvar *r-started* nil)

(defun string-sequence-to-foreign-string-array (string-sequence)
  (let ((n (length string-sequence)))
    (let ((foreign-array (foreign-alloc :pointer :count n)))
      (dotimes (i n)
 	(setf (mem-aref foreign-array :pointer i)
	      (foreign-string-alloc (elt string-sequence i))))
      (values foreign-array n))))

(defmacro with-foreign-string-array ((name length str-array) &body body)
  (let ((ctr (gensym)))
    `(multiple-value-bind (,name ,length) 
      (string-sequence-to-foreign-string-array ,str-array)    
      (unwind-protect
	   ,@body
	(progn
	  (dotimes (,ctr ,length)
	    (foreign-string-free 
	     (mem-aref ,name :pointer ,ctr)))
	  (foreign-free ,name))))))


(defun start-rclg (&optional (argv *r-default-argv*))
  (unless *r-started*
    (progn
      #+sbcl(sb-int:set-floating-point-modes :traps (list :overflow))
      (setf *r-started*
	    (with-foreign-string-array (foreign-argv n argv)
	      (%rf-init-embedded-r n foreign-argv))))))
