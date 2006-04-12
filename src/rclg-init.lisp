;;; RCLG: R-CommonLisp Gateway

;;; Copyright (c) --2006, rif@mit.edu.  All Rights Reserved.
;;; Author: rif@mit.edu
;;; Maintainers: rif@mit.edu, AJ Rossini <blindglobe@gmail.com>
;;; License:

;;; Intent: R evaluator process initialization and maintenance.  A
;;; good deal of this is SBCL specific, and is flagged if so.  At some
;;; point, a means of handling non-SBCL variants will be important.
;;; But first things first.

;;; Basic Usage:
;; (start-rclg) ;; initializes RCLG functions.
;; (update-R)   ;; sync all threads
;;

(defpackage :rclg-init
  (:use :common-lisp :rclg-foreigns :cffi)
  (:export start-rclg update-R 
	   start-rclg-update-thread stop-rclg-update-thread 
	   with-R-traps with-r-mutex))

(in-package :rclg-init)

;; initialization
(defvar *r-default-argv* '("rclg" "-q" "--vanilla" "--max-ppsize=50000")) ; last term to incr stack
(defvar *r-started* nil)

;; thread management
(defvar *do-rclg-updates-p* nil)
(defvar *rclg-update-sleep-time* .1)
(defvar *rclg-update-mutex* (sb-thread:make-mutex))

#+sbcl
(defmacro with-r-traps (&body body)
  "Protect against R signaling wierdness to initialize the R REPL."
  `(sb-int:with-float-traps-masked  (:invalid :divide-by-zero)
    ,@body))

#+sbcl
(defmacro with-r-mutex (&body body)
  "FIXME:AJR: eval body in an mutex thread, updating as necessary.  AJR is
not clear about the use-case for this macro."  
  `(sb-thread:with-mutex (*rclg-update-mutex*)
    ,@body))

(defun update-R ()
  "Update and sync all SBCL threads containing R processes." 
  (with-r-traps
    (with-r-mutex
      (%r-run-handlers *r-input-handlers*
		       (%r-check-activity 10000 0)))))

(defun start-rclg-update-thread ()
  "Update R threads.
FIXME:AJR add use case for when/if needed at by a user."
  (setf *do-rclg-updates-p* t)
  #+sbcl
  (sb-thread:make-thread 
   #'(lambda ()
       (loop while *do-rclg-updates-p*
	     do 
	     (progn
	       (update-R)
	       (sleep *rclg-update-sleep-time*)))))
  #+clisp(error "not implemented yet") 
  #+cmu(error "not implemented yet"))



(defun stop-rclg-update-thread ()
  "FIXME: this was initially flagged as SBCL only, but it is more
generic.  However, it isn't useful until implemented on other CL
systems." 
  (setf *do-rclg-updates-p* nil))
	       

(defun string-sequence-to-foreign-string-array (string-sequence)
  "CFFI-based conversion.  Isn't there a new CFFI function for this?
FIXME:AJR: need to check."
  (let ((n (length string-sequence)))
    (let ((foreign-array (foreign-alloc :pointer :count n)))
      (dotimes (i n)
 	(setf (mem-aref foreign-array :pointer i)
	      (foreign-string-alloc (elt string-sequence i))))
      (values foreign-array n)))) 

(defmacro with-foreign-string-array
    ((name length str-array) &body body)
  "CFFI-based conversion.  Isn't this implemented in CFFI? FIXME:AJR:
need to check."
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
  "Initial the first R thread, perhaps with different arguments."  
  (unless *r-started*
    (progn
      #+sbcl(sb-int:set-floating-point-modes :traps (list :overflow))
      (setf *r-started*
	    (progn
	      (with-foreign-string-array (foreign-argv n argv)
		(%rf-init-embedded-r n foreign-argv))
	      #+sbcl(start-rclg-update-thread))))))
;; FIXME:AJR: above is silly -- ought to condition in function rather than here. 


;; Do we really want to force this, or should we wait and let the
;; user do this action? 

;;(eval-when (:load-toplevel)
;;  (start-rclg))
