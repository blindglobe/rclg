(defpackage :rclg-convert
  (:use :common-lisp :cffi :rclg-util :rclg-types :rclg-foreigns)
  (:export :*r-na* :convert-to-r :convert-from-r :r-bound :r-nil))

(in-package :rclg-convert)

(eval-when (:compile-toplevel :load-toplevel)
  (defvar *r-NA-internal* -2147483648) ;;  PLATFORM SPECIFIC HACK!!!
  (defvar *r-na* 'r-na)
  )

;;; Basic Conversion Routines
(defun robj-to-int (robj &optional (i 0))
  "Returns the integer inside an R object.  Assumes it's an
integral robj.  Converts NA's"
  (let ((result (mem-aref (%INT robj) :int i)))
    (if (= result *r-NA-internal*)
	*r-NA*
      result)))

(defun robj-to-logical (robj &optional (i 0))
  "Returns the logical inside an R object.  Assumes it's an
logical robj."
  (= 1 (robj-to-int robj i)))

(defun robj-to-double (robj &optional (i 0))
  "Returns the double-float inside an R object.  Assumes it's an
double-float robj."
  (declare (type fixnum i))
  (mem-aref (%real robj) :double i))

(defun robj-to-complex (robj &optional (i 0))
  "Returns the complex number inside an R object.  Assumes it's a
complex robj."
  (let ((complex (mem-aref (%COMPLEX robj) 'r-complex i)))
    (complex (foreign-slot-value complex 'r-complex 'r)
	     (foreign-slot-value complex 'r-complex 'i))))

(defun robj-to-string (robj &optional (i 0))
  "Convert an R object to a string.  Assumes it's a string robj."
  (foreign-string-to-lisp (%r-char (%string-elt robj i))))

(defgeneric convert-to-r (value)
  (:method ((n null)) *r-nil-value*)
  (:method ((i integer)) (int-to-robj i))
  (:method ((f float)) (float-to-robj f))
  (:method ((d double-float)) (double-float-to-robj d))
  (:method ((c complex)) (complex-to-robj c))
  (:method ((s string)) (string-to-robj s))
  (:method ((s sequence)) (sequence-to-robj s))
  (:method ((s sexp-holder)) (slot-value s 'sexp))
  (:method ((v vector)) (sequence-to-robj v))
  (:method ((a array)) (array-to-robj a))
  (:method ((k symbol)) k)) ;; for keywords or for T

(defmethod convert-to-r ((na (eql *r-NA*)))
  (convert-to-r *r-NA-internal*))

(defmethod convert-to-r ((l (eql t)))
  "Returns an R object corresponding to the logical t."
  (let ((robj (%rf-alloc-vector #.(sexp-elt-type :lglsxp) 1)))
    (setf (mem-ref (%LOGICAL robj) :int) 1)
    robj))

(defun int-to-robj (n)
  "Returns an R object corresponding to an integer."
  (let ((robj (%rf-alloc-vector #.(sexp-elt-type :intsxp) 1)))
    (setf (mem-ref (%INT robj) :int) n)
    robj))

(defun float-to-robj (f)
  "Returns an R object corresponding to a floating point number.  Coerces
the number to double-float."
  (double-float-to-robj (coerce f 'double-float)))


(defun double-float-to-robj (d)
  "Returns an R object corresponding to a double floating point number."
  (let ((robj (%rf-alloc-vector #.(sexp-elt-type :realsxp) 1)))
    (setf (mem-ref (%real robj) :double) d)
    robj))

(defun complex-to-robj (c)
  "Returns an R object corresponding to a CL complex number.  Coerces the
real and imaginary points to double-float."
  (let ((robj (%rf-alloc-vector #.(sexp-elt-type :cplxsxp) 1)))
    (let ((complex (mem-ref (%COMPLEX robj) 'r-complex)))
      (setf (foreign-slot-value complex 'r-complex 'r) 
	    (coerce (realpart c) 'double-float)
	    (foreign-slot-value complex 'r-complex 'i)
	    (coerce (imagpart c) 'double-float)))
    robj))

(defun string-to-robj (string)
  "Convert a string to an R object.  I *believe* that %rf-mkchar does
a copy.  At least, I hope it does."
  (let ((robj (%rf-alloc-vector (sexp-elt-type :strsxp) 1))
        (str-sexp
	 (with-foreign-string (s string)
           (%rf-mkchar s))))
    (%set-string-elt robj 0 str-sexp)
    robj))


(defun array-to-vector-column-major (array)
  (let ((result 
	 (make-array (array-total-size array) 
		     :element-type (array-element-type array))))
    (over-column-major-indices (array cmi rmi)
	(setf (aref result rmi) (row-major-aref array cmi)))
    result))


(defun array-to-robj (a)
  "Convert an array to an R object."
  (let ((column-vector 
	 (convert-to-r (array-to-vector-column-major a))))
    (%rf-set-attrib column-vector 
		    *r-dims-symbol* 
		    (convert-to-r (array-dimensions a)))
    column-vector))

;;; Sequence conversion
(eval-when (:compile-toplevel :load-toplevel)
  (defvar +int-seq+ 1)
  (defvar +float-seq+ 2)
  (defvar +complex-seq+ 3)
  (defvar +string-seq+ 4)
  (defvar +any-seq+ 0)
  
  (defvar +seq-fsm+ #2A((0 0 0 0 0)
			(0 1 2 3 0)
			(0 2 2 3 0)
			(0 3 3 3 0)
			(0 0 0 0 4)))
  )


(defun type-to-int (obj)
  (cond ((eql obj *r-na*) +int-seq+)
	(t (typecase obj
	     (integer +int-seq+)
	     (float +float-seq+)
	     (complex +complex-seq+)
	     (string +string-seq+)
	     (t +any-seq+)))))

(defun sequence-to-robj (seq)
  (let ((len (length seq)))
    (let ((robj (%rf-protect (%rf-alloc-vector #.(sexp-elt-type :vecsxp) len)))
	  (state (type-to-int (elt seq 0)))
	  (i 0))
      (typecase seq 
	((simple-array double-float)
	 (%double-float-vec-to-R (sb-sys:vector-sap seq) len robj))
;; 	 (map nil
;; 	      (lambda (e)
;; 		(%set-vector-elt robj i (double-float-to-robj e))
;; 		(incf i))
;; 	      seq))
	((simple-array fixnum)
	 (%integer-vec-to-R (sb-sys:vector-sap seq) len robj 4))
	(t 
	 (map nil
	      (lambda (e)
		(%set-vector-elt robj i (convert-to-r e))
		(setf state (aref +seq-fsm+ state (type-to-int e))
		      i     (+ i 1)))
	      seq)))
      (let ((result
	     (case state
	       (#.+int-seq+ (%rf-coerce-vector robj #.(sexp-elt-type :intsxp)))
	       (#.+float-seq+ (%rf-coerce-vector robj #.(sexp-elt-type :realsxp)))
	       (#.+complex-seq+ (%rf-coerce-vector robj #.(sexp-elt-type :cplxsxp)))
	       (#.+string-seq+ (%rf-coerce-vector robj #.(sexp-elt-type :strsxp)))
	       (t robj))))
	(%rf-unprotect 1)
	(values result state)))))


(defun convert-from-r (robj)
  "Attempt to convert a general R value to a CL value."
  (if (r-nil robj)
      nil
    (let ((length (%rf-length robj)))
      (if (= length 0) 
	  nil
	(let ((result (convert-from-r-seq robj length)))
	  (if (= length 1) 
	      (aref result 0)
	    result))))))

(defun sexptype-to-element-type (type)
  (case type
    (#.(sexp-elt-type :intsxp) 'integer) ;;; Sigh, not fixnum.
    (#.(sexp-elt-type :lglsxp) 'boolean)
    (#.(sexp-elt-type :realsxp) 'double-float)
    (#.(sexp-elt-type :cplxsxp) 'complex)
    (#.(sexp-elt-type :strsxp) 'string)
    (#.(sexp-elt-type :listsxp) 't)
    (#.(sexp-elt-type :vecsxp) 't)
    (t (error "Unknown type"))))

(defun convert-from-r-seq (robj length)
  "Convert an r-sequence into CL."
  (let* ((type (sexptype robj))
	 (result (make-array length 
			     :element-type (sexptype-to-element-type type))))
    (dotimes (i length)
      (setf (aref result i)
	    (case type
	      (#.(sexp-elt-type :intsxp) (robj-to-int robj i))
	      (#.(sexp-elt-type :lglsxp) (robj-to-logical robj i))
	      (#.(sexp-elt-type :realsxp) (robj-to-double robj i))
	      (#.(sexp-elt-type :cplxsxp) (robj-to-complex robj i))
	      (#.(sexp-elt-type :strsxp) (robj-to-string robj i))
	      (#.(sexp-elt-type :listsxp) (convert-from-r (%rf-elt robj i)))
	      (#.(sexp-elt-type :vecsxp) (convert-from-r (%vector-elt robj i)))
	      (t (error "Unknown type")))))
    (values result type)))

(defun r-bound (robj)
  "Checks to see if an R SEXP is (has the address of) the
*r-unbound-value* SEXP."
  (not (= (pointer-address robj) 
	  (pointer-address *r-unbound-value*))))

(defun r-nil (robj)
  "Checks to see if an R SEXP is (has the address of) the *r-nil-value* SEXP."
  (= (pointer-address robj)
     (pointer-address *r-nil-value*)))
