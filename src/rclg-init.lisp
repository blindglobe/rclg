(defpackage :rclg-init
  (:use :common-lisp :rclg-foreigns :cffi)
  (:export :start-rclg :with-R-traps :update-R 
	   :start-rclg-update-thread 
	   :stop-rclg-update-thread
	   :with-r-mutex))

(in-package :rclg-init)

(defvar *r-default-argv* '("rclg" "-q" "--vanilla"))
(defvar *r-started* nil)
(defvar *do-rclg-updates-p* nil)
(defvar *rclg-update-sleep-time* .1)
(defvar *rclg-update-mutex* (sb-thread:make-mutex))

(defmacro with-r-traps (&body body)
  `(sb-int:with-float-traps-masked  (:invalid :divide-by-zero)
    ,@body))

(defmacro with-r-mutex (&body body)
  `(sb-thread:with-mutex (*rclg-update-mutex*)
    ,@body))

(defun update-R ()
  (with-r-traps
    (with-r-mutex
      (%r-run-handlers *r-input-handlers*
		       (%r-check-activity 10000 0)))))

#+sbcl
(defun start-rclg-update-thread ()
  (setf *do-rclg-updates-p* t)
  (sb-thread:make-thread 
   #'(lambda ()
       (loop while *do-rclg-updates-p*
	     do 
	     (progn
	       (update-R)
	       (sleep *rclg-update-sleep-time*))))))

#+sbcl
(defun stop-rclg-update-thread ()
  (setf *do-rclg-updates-p* nil))
	       

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
	    (progn
	      (with-foreign-string-array (foreign-argv n argv)
		(%rf-init-embedded-r n foreign-argv))
	      #+sbcl(start-rclg-update-thread))))))

(eval-when (:load-toplevel)
  (start-rclg))
