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

;;; Intent: higher level abstractions on top of RCLG.

(defpackage :rclg-abstractions
  (:use :common-lisp :rclg-control :rclg-util)
  (:export :def-r-call))

(in-package :rclg-abstractions)

;;; Internal functions

(defun remove-keys-from-plist (plist keys)
  "Returns a copy of plist with keys removed.  For re-using the &REST arg after
removing some options."
  (when plist
    (append (unless (member (car plist) keys) (subseq plist 0 2))
	    (remove-keys-from-plist (cddr plist) keys))))
  
(defun to-keyword (symbol)
  (intern (symbol-name symbol) :keyword))

(defun atom-or-first (val)
  (if (atom val) val (car val)))

;;; External functions

(defmacro def-r-call ((function-name r-name conversion &rest required-args) 
		      &rest keyword-args)
  "Utility macro for defining calls to R.  Defines a CL function
function-name that calls the R function r-name.  The conversion
argument specifices what happens to the result: :convert converts the
result to CL, :raw yields an unconverted R sexp, and :no-result throws
away the results (for side effects only).  The keyword args allow
specification of default values, others keys are allowed.  For example,

  (def-r-call (r-hist hist :no-result sequence) main xlab (breaks 50)
              (probability t) (col \"blue\"))

creates a CL function r-hist that calls the R function hist on a
sequence, returning no results.  The keywords :main and :xlab are
passed with default values nil, and the other keywords are passed with
the chosen values.  (Try (r-hist (rnbi rnorm 1000)), for instance.)
"
  (let* ((keyword-names (mapcar #'atom-or-first keyword-args))
	 (keywords (mapcar #'to-keyword keyword-names))
	 (rest-sym (gensym)))
    `(defun ,function-name (,@required-args 
			 &rest ,rest-sym 
			 &key ,@keyword-args
			 &allow-other-keys)
      (,(case conversion
	      (:convert 'r)
	      (:raw 'rnb)
	      (:no-result 'rnr))
       ,r-name 
       ,@required-args
       ,@(mapcan #'(lambda (k n) (list k n)) 
		 keywords 
		 keyword-names)
       (remove-keys-from-plist ,rest-sym ',keywords)))))
