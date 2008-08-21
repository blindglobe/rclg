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

;;; Intent: initialize environment stuff.  Purely developer level, no
;;; user tools.

(defpackage :rclg-load
  (:use :common-lisp :cffi :rclg-cffi-sysenv)
  (:export load-r-libraries *rclg-loaded*))

(in-package :rclg-load)

;;;* Variables for RCLG state/location

(defvar *rclg-loaded* nil
  "True once rclg is loaded, nil otherwise (including errors).")


;; The user MUST make sure *R-HOME-STR* points to the right place!
;; --rif 

;; AJR: we do this by testing directories existence.  Rif's is first,
;; Debian's is second.  A better way to do this would be to check that
;; the library exists, but we could do that later if we don't need 

(eval-when (:compile-toplevel :load-toplevel)
  (defvar *R-HOME-STR* 
    (namestring
     (cond 
      ;; this is made confusing -- SBCL is lax and lets us use
      ;; probe-file, but CLISP is more rigourous and forces an error
      ;; in such cases.
      #+sbcl((probe-file #p"/home/rif/RCLG-test/R-2.3.1"))
      #+sbcl((probe-file #p"/usr/lib/R"))
      #+clisp((ext:probe-directory #p"/home/rif/RCLG-test/R-2.3.1/"))
      #+clisp((ext:probe-directory #p"/usr/lib/R/"))
       (t (error "R not found."))))))

(posix-setenv "R_HOME" *R-HOME-STR* 1)

(defun load-r-libraries () 
  (unless *rclg-loaded*
    (progn
      (define-foreign-library libR
	  (t (:default #.(concatenate 'string *R-HOME-STR* "/lib/libR"))))
      (use-foreign-library libR)
      (setf *rclg-loaded* t))))

;; *rclg-loaded*
;; (load-r-libraries)