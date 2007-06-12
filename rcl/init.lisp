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

(eval-when (:compile-toplevel :load-toplevel :execute)
  ;; LD_LIBRARY_PATH
  #+clisp (let ((current (ext:getenv "LD_LIBRARY_PATH")))
	    (unless (search *r-lib-path* current)
	      (setf (ext:getenv "LD_LIBRARY_PATH")
		    (concatenate 'string current (when current ":") *r-lib-path*))))
  #+sbcl (let ((current (sb-posix:getenv "LD_LIBRARY_PATH")))
	   (unless (search *r-lib-path* current)
	     (sb-posix:putenv 
	      (concatenate 'string "LD_LIBRARY_PATH=" current (when current ":") *r-lib-path*))))
  #+allegro (let ((current (sys:getenv "LD_LIBRARY_PATH")))
	      (unless (search *r-lib-path* current)
		(setf (sys:getenv "LD_LIBRARY_PATH")
		      (concatenate 'string current (when current ":") *r-lib-path*))))
  #+lispworks (let ((current (lispworks:environment-variable "LD_LIBRARY_PATH")))
		(unless (search *r-lib-path* current)
		  (setf (lispworks:environment-variable "LD_LIBRARY_PATH")
			(concatenate 'string current (when current ":") *r-lib-path*)))))

(defun set-r-home (r-home)
  #+clisp (setf (ext:getenv "R_HOME") r-home)
  #+sbcl (sb-posix:putenv (concatenate 'string "R_HOME=" r-home))
  #+allegro (setf (sys:getenv "R_HOME") r-home)
  #+lispworks (setf (lispworks:environment-variable "R_HOME") r-home)
  #+openmcl (ccl::setenv "R_HOME" r-home)
  #+cmu (unless (equal (cdr (assoc :r_home ext:*environment-list*)) r-home)
	  (error "for cmucl the R_HOME variable has to be set before lisp is started (got ~A, expected ~A)" (cdr (assoc :r_home ext:*environment-list*)) r-home)))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defvar *r-lib-loaded* nil)
  (unless *r-lib-loaded*
    (cffi:load-foreign-library *r-lib*)
    (setf *r-lib-loaded* t)))

(defvar *r-session* nil)

(cffi:defcvar "R_SignalHandlers" :unsigned-long)
(cffi:defcvar "R_CStackLimit" :unsigned-long)

(defun disable-stack-checking ()
  (setf *r-cstacklimit* (1- (expt 2 32))))

(defun disable-signal-handling ()
  (setf *r-signalhandlers* 0))

(defun r-init ()
  (if *r-session*
      (warn "R was already running")
      (progn
	(set-r-home *r-home*)
 	(disable-signal-handling)
	(cffi:with-foreign-object (argv :pointer 3)
	  (setf (cffi:mem-aref argv :pointer 0) (cffi:foreign-string-alloc "rcl"))
	  (setf (cffi:mem-aref argv :pointer 1) (cffi:foreign-string-alloc "--silent"))
	  (setf (cffi:mem-aref argv :pointer 2) (cffi:foreign-string-alloc "--vanilla"))
	  (rf-initembeddedr 3 argv))
	#+(and linux (or sbcl cmu))(disable-stack-checking)
	(setf *r-session* t))))

#+(or) ;;this kills lisp as well!
(defun r-quit ()
  (if *r-session*
      (r-funcall "q" "no") ;; see Rpostscript.c
      (warn "R was not running"))
  (setf *r-session* nil))
