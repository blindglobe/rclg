;;;
;;; ch-util.cl -- various lisp utilities that make my life easier
;;;
;;; Author: Cyrus Harmon <ch-lisp@bobobeach.com>
;;; Time-stamp: <2006-01-20 12:57:27 sly>
;;;

(in-package :ch-util)

;;; Miscellaneous list utilities

(flet ((cca (l1 l2)
	 (dolist (x l1)
	   (let ((y (member x l2)))
	     (if y (return y))))))
  (defun closest-common-ancestor (itm &rest lis)
    (if (null lis)
	itm
	(cca itm (apply #'closest-common-ancestor lis)))))

;;; Miscellaneous class utilities
    
(defun subclassp (c1 c2)
  (subtypep (class-name c1) (class-name c2)))

;;; Miscellaneous string utilities
 
(defun strcat (&rest strs)
  (apply #'concatenate 'string strs))

(defun trim (seq suffix)
  (subseq seq 0 (search suffix seq)))

;;; This is a hack so that one day we might run under a case-sensitive lisp
;;; like Allegro mlisp (modern lisp). For now we encapsulate the uppercasing
;;; here so we can do the right thing later.
(defun interncase (x)
  (string-upcase x))

;;; simple wrapper for intern to allow us 
(defun make-intern (x &optional (package *package*))
  (intern (interncase x) package))

(defun make-keyword (x)
  (make-intern x 'keyword))

(defun keyword-list-names (k)
  (mapcar #'(lambda (x)
	    (symbol-name x))
	k))

(defun double-float-divide (&rest args)
  (apply #'/ (mapcar #'(lambda (x) (coerce x 'double-float)) args)))

(defun single-float-divide (&rest args)
  (apply #'/ (mapcar #'(lambda (x) (coerce x 'single-float)) args)))

(defmacro mapv (function &rest vals)
  `(values-list (mapcar ,function (multiple-value-list ,@vals))))

;;
;; Silly little macro to do a postincrement, that is
;; return the value of the place prior to incrementing
;; it. Like incf, this only works on valid places.
;;
(defmacro postincf (x &optional (step 1))
  (let ((pre (gensym)))
    `(let ((,pre ,x))
       (incf ,x ,step)
       ,pre)))

;; another silly little function.
;; this one to sum a 2d array.
;; undoubtedly a better way to do this.
(defun array-sum (a)
  (destructuring-bind (height width) (array-dimensions a)
    (let ((acc 0))
      (dotimes (h height)
	(dotimes (w width)
	  (incf acc (aref a h w))))
      acc)))

(defun array-from-string (str)
  (let ((a (make-array (length str) :element-type '(unsigned-byte 8))))
    (dotimes (i (length str))
      (setf (aref a i) (char-code (elt str i))))
    a))

(defun str-to-int (str)
  (let ((intval 0))
    (map nil #'(lambda (c) (setf intval (+ (ash intval 8) (char-code c)))) str)
    intval))

(defun int-to-str (i &optional s)
  (if (> i 0)
      (let ((r (mod i 256)))
	(int-to-str (ash i -8) (cons (code-char r) s)))
      (coerce s 'string)))


(defparameter *months*
  '((1 . "January")
    (2 . "February")
    (3 . "March")
    (4 . "April")
    (5 . "May")
    (6 . "June")
    (7 . "July")
    (8 . "August")
    (9 . "September")
    (10 . "October")
    (11 . "November")
    (12 . "December")))
     
(defun get-current-date ()
  (multiple-value-bind (sec min hour date mon year dow dst tz)
      (get-decoded-time)
    (declare (ignore sec min hour dow dst tz))
    (format nil
            "~A ~A, ~A"
            (cdr (assoc mon *months*))
            date
            year)))