;; -*- mode:lisp -*-

;;; (c) 2005--2006, Cyrus Harmon, all rights reserved.
;;; Author: Cyrus Harmon
;;; Maintainers: Cyrus Harmon and AJ Rossini

;;; Purpose: mapping CL/R objects, transfer/conversion.

(in-package :clsr)

(defun matrix-dim (matsxp)
  (clsr::r-sexp-to-lisp-sexp
   (R::|Rf_getAttrib| matsxp R::|R_DimSymbol|)))

(defmacro def-typed-rref (name r-type-fun lisp-type)
  `(progn
     (eval-when (:compile-toplevel :load-toplevel :execute)
       (declaim (inline ,name (setf ,name)))
       (declaim (ftype (function (r-sexp
                                  fixnum fixnum &key (:cols fixnum)) ,lisp-type) ,name))
       (declaim (ftype (function (,lisp-type
                                  r-sexp
                                  fixnum fixnum &key (:cols fixnum)) ,lisp-type) (setf ,name))))
     (defun ,name (matsxp y x &key (cols (aref (matrix-dim matsxp) 1)))
       (declare (type fixnum y x cols)
                (type r-sexp matsxp))
       (locally (declare (optimize (speed 3) (space 0) (safety 0)))
         (sb-alien:deref (,r-type-fun matsxp) (+ (the fixnum (* cols y)) x))))
     
     (defun (setf ,name) (val matsxp y x &key (cols (aref (matrix-dim matsxp) 1)))
       (declare (type fixnum y x cols)
                (type ,lisp-type val)
                (type r-sexp matsxp))
       (locally (declare (optimize (speed 3) (space 0) (safety 0)))
         (setf (sb-alien:deref (,r-type-fun matsxp) 
                               (+ (the fixnum (* cols y)) x)) val)))))

(def-typed-rref real-rref r::|REAL| double-float)
(def-typed-rref logical-rref r::|LOGICAL| (unsigned-byte 1))
(def-typed-rref integer-rref r::|INTEGER| integer)


;;; Have to treat complex differently as we need to package/unpackage
;;; complex values from an R complex struct... :-(
(defun complex-rref (matsxp y x)
  (let ((cols (aref (matrix-dim matsxp) 1)))
    (r-complex
     (sb-alien:deref (r::|COMPLEX| matsxp) (+ (* cols y) x)))))

(defun (setf complex-rref) (val matsxp y x)
  (let ((cols (aref (matrix-dim matsxp) 1)))
    (setf (r-complex (sb-alien:deref (r::|COMPLEX| matsxp) (+ (* cols y) x))) val)))

(defparameter *r-rref-hash* (make-hash-table :test 'equal))
(dolist
    (x `((,r::|NILSXP| . ,(constantly nil))
         (,r::|LGLSXP| . logical-rref)
         (,r::|INTSXP| . integer-rref)
         (,r::|REALSXP| . real-rref)
         (,r::|CPLXSXP| . complex-rref)))
  (setf (gethash (car x) *r-rref-hash*) (cdr x)))

(defparameter *r-setf-rref-hash* (make-hash-table :test 'equal))
(dolist
    (x `((,r::|LGLSXP| . ,#'(setf logical-rref))
         (,r::|INTSXP| . ,#'(setf integer-rref))
         (,r::|REALSXP| . ,#'(setf real-rref))
         (,r::|CPLXSXP| . ,#'(setf complex-rref))))
  (setf (gethash (car x) *r-setf-rref-hash*) (cdr x)))

(defun rref (matsxp y x)
  (let ((fun (gethash (r::|TYPEOF| matsxp) *r-rref-hash*)))
    (when fun (funcall fun matsxp y x))))

(defun (setf rref) (val matsxp y x)
  (let ((fun (gethash (r::|TYPEOF| matsxp) *r-setf-rref-hash*)))
    (when fun (funcall fun val matsxp y x))))

