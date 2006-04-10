;;;
;;; hash-table.cl -- various lisp utilities for hash-tables
;;;
;;; Author: Cyrus Harmon <ch-lisp@bobobeach.com>
;;;

(in-package :ch-util)

;;; Miscellaneous hash-table utilities

(defun make-hash-table-from-plist (plist &key (test #'eql))
  (let ((h (make-hash-table :test test)))
    (loop for (x y) on plist by #'cddr
       do (setf (gethash x h) y))
    h))

(defun make-hash-table-from-alist (alist &key (test #'eql))
  (let ((h (make-hash-table :test test)))
    (loop for (x . y) in alist
       do (setf (gethash x h) y))
    h))
