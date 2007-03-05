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

;;; Intent: This code supports interaction between R's SEXPs and CL. 
;;; FIXME:AJR:  worth having a CLOSy style interface?

(defpackage :rclg-access
  (:use :common-lisp :cffi :rclg-types)
  (:export :r-setcar :r-car :r-cdr))

(in-package :rclg-access)

;;; Internal 

(defun r-get-union (sexp)
  "returns a component of an R SEXP."
  (foreign-slot-value sexp 'sexprec 'sxp-int-union))

(defun r-get-listsxp (sexp)
  "returns an R LIST SEXP."
  (foreign-slot-value 
   (r-get-union sexp) 
   'sexprec-internal-union 
   'listsxp))

;;; Exported

(defun r-car (sexp)
  (foreign-slot-value (r-get-listsxp sexp) 'listsxp-struct 'carval))

(defun r-setcar (sexp value)
  (setf (foreign-slot-value (r-get-listsxp sexp) 'listsxp-struct 'carval)
	value))

(defun r-cdr (sexp)
  (foreign-slot-value (r-get-listsxp sexp) 'listsxp-struct 'cdrval))
