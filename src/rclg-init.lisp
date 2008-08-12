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

;;; Intent: R evaluator process initialization and maintenance.  A
;;;         good deal of this is SBCL specific, and is flagged if so.
;;;         At some point, a means of handling non-SBCL variants will
;;;         be important.
;;;         But first things first.

;;; Basic Usage:
;; (start-rclg) ;; initializes RCLG functions.
;; (update-R)   ;; sync all threads
;;

(defpackage :rclg-init
  (:use :common-lisp :rclg-foreigns :cffi)
  (:export :start-rclg :update-R :*r-started*
	   :start-rclg-update-thread :stop-rclg-update-thread 
	   :with-R-traps :with-r-mutex))

(in-package :rclg-init)

;; initialization
(defvar *r-default-argv*
  '("rclg" "-q" "--vanilla" "--max-ppsize=50000")) ; last term to incr stack
(defvar *r-started* nil)

;; thread management
(defvar *do-rclg-updates-p* nil)
(defvar *rclg-update-sleep-time* .1)
(defvar *rclg-update-mutex*
  #+sbcl(sb-thread:make-mutex)
  #-sbcl nil
  )

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

;; FIXME:AJR what is the point of the equiv comments?  i.e. signed-long?
(defcvar "R_CStackLimit"
    #-:x86-64 :unsigned-long
    #+:x86-64 :unsigned-long-long)
(defcvar "R_SignalHandlers"
    #-:x86-64 :unsigned-long
    #+:x86-64 :unsigned-long-long)

(defun r-turn-off-signal-handling ()
  "Turn of stack checking, based on changes present in 2.3.1 release." 
  (setf *R-SIGNALHANDLERS* 0))

(defun r-turn-off-stack-checking ()
  ;; (setf *R-CSTACKLIMIT* -1))
  ;; This following is a complete hack since CFFI currently doesn't
  ;; believe the above (it thinks that it's unsigned so upchucks)
  (setf *R-CSTACKLIMIT*
        #-:x86-64 #.(- (expt 2 32) 1)
        #+:x86-64 #.(- (expt 2 64) 1)))

(defun check-stack ()
  (format t "STACK: LIMIT ~A, HANDLERS ~A~%" 
	  *R-CSTACKLIMIT* *R-SIGNALHANDLERS*)
  (force-output t))

(defun start-rclg (&optional (argv *r-default-argv*))
  "Initial the first R thread, perhaps with different arguments."  
  (r-turn-off-signal-handling)
  (unless *r-started*
    (progn
      #+sbcl(sb-int:set-floating-point-modes :traps (list :overflow))
      (setf *r-started*
	    (progn
	      (with-foreign-string-array (foreign-argv n argv)
		(%rf-initialize-r n foreign-argv)
		(r-turn-off-stack-checking)
		(%setup-r-main-loop)
		#+sbcl(start-rclg-update-thread)))))))

;; FIXME:AJR: Do we really want to force this, or should we wait and
;; let the user do this when appropriate?
;; We let the user do it when ready.

;;(eval-when (:load-toplevel)
;;  (start-rclg))
