;; -*- mode:lisp -*-

;;; (c) 2005--2006, Cyrus Harmon, all rights reserved.
;;; Author: Cyrus Harmon
;;; Maintainers: Cyrus Harmon and AJ Rossini

;;; Purpose: object reference registry.

(in-package :clsr)

(defclass object-registry ()
  ((ids :accessor ids :initform (make-hash-table))
   (object-id-counter :accessor counter :initform 0)
   (max-id :reader max-id :initform most-positive-fixnum)))

(defmethod get-object (id (registry object-registry))
  (gethash id (ids registry)))

(defmethod set-object (id object (registry object-registry))
  (setf (gethash id (ids registry)) object))

(defmethod remove-id (id (registry object-registry))
  (remhash id (ids registry)))

(defmethod next-id ((registry object-registry))
  (let ((id (incf (counter registry))))
    (cond ((= id most-positive-fixnum)
           (setf (counter registry) 0)
           (next-id registry))
          (t (if (get-object id registry)
                 (next-id registry)
                 id)))))

(defmethod register-object (object (registry object-registry))
  (let ((id (next-id registry)))
    (set-object id object registry)
    (values id object)))

(defmethod unregister-id (id (registry object-registry))
  (let ((object (gethash id (ids registry))))
    (remove-id id registry)
    (values id object)))





