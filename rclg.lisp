;;; Copyright rif 2004

(declaim (optimize (speed 1) (debug 3) (safety 3)))
;; (declaim (optimize (speed 1) (safety 3) (debug 3)))

(defpackage "RCLG"
  (:use :common-lisp :uffi :rclg-load :common-idioms)
  (:export :start-r :rclg :r :sexp :*backconvert* :*r-started*
	   :r-convert :r-do-not-convert :convert-to-r
	   :sexp-not-needed :update-r :def-r-call :*r-NA* :r-na))

(in-package :rclg)

(eval-when (:load-toplevel)
  (unless *rclg-loaded*
    (error "rclg-load has not loaded the R libraries.")))

(defvar *r-default-argv* '("rclg" "-q" "--vanilla"))

(defconstant *r-NA-internal* -2147483648) ;;  PLATFORM SPECIFIC HACK!!!
(defconstant *r-na* 'r-na)

(defparameter *r-started* nil)


;;; Types
(eval-when (:compile-toplevel :load-toplevel)
  (defmacro def-typed-struct (struct-name type &rest field-names)
    `(def-struct ,struct-name
       ,@(mapcar (lambda (n) `(,n ,type)) field-names)))
  
  (defmacro def-voidptr-struct (struct-name &rest field-names)
    "Define a structure in which all elements are of type pointer-to-void."
    `(def-typed-struct ,struct-name :pointer-void ,@field-names))
  
  (defmacro def-r-var (r-name cl-name)
    `(def-foreign-var (,r-name ,cl-name) sexp "R")))

(def-foreign-type foreign-string '(* :unsigned-char))

;;; This struct is bitfields.
(def-struct sxpinfo-struct (data :unsigned-int))

;; The structures in the union in the SEXPREC
(def-struct primsxp-struct (offset :int))
(def-voidptr-struct symsxp-struct pname value internal)
(def-voidptr-struct listsxp-struct carval cdrval tagval)
(def-voidptr-struct envsxp-struct frame enclos hashtab)
(def-voidptr-struct closxp-struct formals body env)
(def-voidptr-struct promsxp-struct value expr env)

(def-union sexprec-internal-union
  (primsxp primsxp-struct)
  (symsxp symsxp-struct)
  (listsxp listsxp-struct)
  (envsxp envsxp-struct)
  (closxp closxp-struct)
  (promsxp promsxp-struct))

(def-struct sexprec
  (sxpinfo sxpinfo-struct)
  (attrib :pointer-self)
  (gengcg-next-node :pointer-self)
  (gengcg-prev-node :pointer-self)
  (u sexprec-internal-union))

(def-foreign-type sexp (* sexprec))

;;; A holder class for a sexp
(defclass sexp-holder () 
  ((sexp :initarg :sexp)
   (protected :initarg :protected :initform nil)))

(defmethod print-object ((s sexp-holder) stream)
  (format stream "#<sexp at 0x~16R, ~A>" 
	  (pointer-address (slot-value s 'sexp))
	  (if (slot-value s 'protected) 'protected 'unprotected)))

;;; Current best guesses

;; (defmacro uffi::get-slot-value (obj type slot)
;;   (let ((obj-sym (gensym)))
;;     `(let ((,obj-sym ,obj))
;;       (declare (type (alien:alien ,(cadr type)) ,obj-sym))
;;       (alien:slot ,obj-sym ,slot))))

(defmacro uffi::get-slot-value (obj type slot)
  `(alien:slot (the (alien:alien (* ,(cadr type))) ,obj)
    ,slot))

(defmacro uffi::get-direct-value (obj type slot)
  `(alien:slot (the (alien:alien ,(cadr type)) ,obj) ,slot))

(defun sexptype (robj)
  "Gets the sexptype of an robj.  WARNING: ASSUMES THAT THE TYPE
IS STORED IN THE LOW ORDER 5 BITS OF THE SXPINFO-STRUCT, AND THAT
IT CAN BE EXTRACTED VIA A 'mod 32' OPERATION!  MAY NOT BE PORTABLE."
  (let ((info (uffi::get-direct-value
	       (get-slot-value robj 'sexprec 'sxpinfo)
	       'sxpinfo-struct 'data)))
    (mod info 32)))

;; We probably only need a few of these, but as soon as I needed two, I 
;; decided to go ahead and type them all in.
(def-enum sexptype (:nilsxp :symsxp :listsxp :closxp :envsxp :promsxp :langsxp
			    :specialsxp :builtinsxp :charsxp 
			    :lglsxp (:intsxp 13) :realsxp :cplxsxp :strsxp 
			    :dotsxp :anysxp :vecsxp :exprsxp :bcodesxp 
			    :extptrsxp :weakrefsxp (:funsxp 99)))

;;; Access functions
(defmacro r-get-u (sexp)
  `(get-slot-value ,sexp 'sexprec 'u))

(defmacro r-get-listsxp (sexp)
  `(uffi::get-direct-value (r-get-u ,sexp) 
    'sexprec-internal-union 
    'listsxp))

(defun r-car (sexp)
  (get-slot-value (r-get-listsxp sexp) 'listsxp-struct 'carval))

(defun r-setcar (sexp value)
  (setf (get-slot-value (r-get-listsxp sexp) 'listsxp-struct 'carval)
	value))

;; (defun r-setcar (sexp value)
;;   (uffi::set-slot-value (r-get-listsxp sexp) listsxp-struct 'carval value))

(defun r-cdr (sexp)
  (get-slot-value (r-get-listsxp sexp) 'listsxp-struct 'cdrval))


(def-function ("SET_TAG" %set-tag)
  ((robj sexp)
   (tag sexp))
  :returning :void)

(def-function ("Rf_length" %rf-length)
  ((x sexp))
  :returning :int)

(def-function ("SET_VECTOR_ELT" %set-vector-elt)
  ((x sexp)
   (i :int)
   (v sexp))
  :returning sexp)

(def-function ("Rf_elt" %rf-elt)
  ((s sexp)
   (i :int))
  :returning sexp)

(def-function ("VECTOR_ELT" %vector-elt)
  ((s sexp)
   (i :int))
  :returning sexp)

(def-function ("Rf_coerceVector" %rf-coerce-vector)
  ((s sexp)
   (type sexptype))
  :returning sexp)

;;; Allocation and Protection

(def-function ("Rf_allocVector" %rf-alloc-vector)
  ((s sexptype)
   (n :int))
  :returning sexp)

;; def-function doesn't take a docstring!  "'Protects' the item
;; (presumably by telling the garbage collector it's in use, although
;; I haven't looked at the internals.  Returns the same pointer you
;; give it."
(def-function ("Rf_protect" %rf-protect)
    ((s sexp))
  :returning sexp)

(def-function ("Rf_unprotect" %rf-unprotect)
    ((n :int))
  :returning :void)

(def-function ("Rf_unprotect_ptr" %rf-unprotect-ptr)
    ((s sexp))
  :returning :void)

(defun sexp-not-needed (poss-sexp)
  (when (and (typep poss-sexp 'sexp-holder)
	     (slot-value poss-sexp 'protected))
    (%rf-unprotect-ptr (slot-value poss-sexp 'sexp))
    (setf (slot-value poss-sexp 'protected) nil))
  poss-sexp)


;;; Variables

(def-r-var "R_GlobalEnv" *r-global-env*)
(def-r-var "R_UnboundValue" *r-unbound-value*)
(def-r-var "R_NilValue" *r-nil-value*)

;;; Foreign string handling.

(defun stringseq-to-foreign-string-array (stringseq)
  (let ((n (length stringseq)))
    (let ((res (uffi:allocate-foreign-object 'foreign-string n)))
      (dotimes (i n)
	(setf (deref-array res '(:array foreign-string) i)
	      (convert-to-foreign-string (elt stringseq i))))
      (values res n))))

(defmacro with-foreign-string-array ((name length str-array) &body body)
  (let ((ctr (gensym)))
    `(multiple-value-bind (,name ,length) (stringseq-to-foreign-string-array ,str-array)    
       (unwind-protect
	   ,@body
	 (progn
	   (dotimes (,ctr ,length)
	     (free-foreign-object (deref-array ,name '(:array foreign-string) ,ctr)))
	   (free-foreign-object ,name))))))

;;; R initialization

(def-function ("Rf_initEmbeddedR" %rf-init-embedded-r)
  ((argc :int)
   (argv (* foreign-string)))
  :returning :int)

(defun start-r (&optional (argv *r-default-argv*))
  (unless *r-started*
    (setf *r-started*
	  (with-foreign-string-array (foreign-argv n argv)
	    (%rf-init-embedded-r n foreign-argv)))))

;;; R evaluation

(def-function ("Rf_findVar" %rf-find-var)
  ((installed sexp)
   (environment sexp))
  :returning sexp)

(def-function ("Rf_install" %rf-install)
  ((ident foreign-string))
  :returning sexp)

(def-function ("R_tryEval" %r-try-eval)
  ((e sexp)
   (env sexp)
   (error-occurred (* :int)))
  :returning sexp)

(defun r-eval (expr)
  (with-foreign-object (e :int)
     (setf (deref-pointer e :int) 0)
     (let ((res (%r-try-eval expr *r-global-env* e)))
       (if (not (= (deref-pointer e :int) 0))
	   (error "Bad expr: ~A" (get-r-error))
	 res))))

(defun r-bound (robj)
  "Checks to see if an R SEXP is (has the address of) the *r-unbound-value* SEXP."
  (not (= (pointer-address robj) 
	  (pointer-address *r-unbound-value*))))

(defun r-nil (robj)
  "Checks to see if an R SEXP is (has the address of) the *r-nil-value* SEXP."
  (= (pointer-address robj)
     (pointer-address *r-nil-value*)))

(defun get-from-name (name)
  "If R has a mapping for name (name is a string), returns the SEXP that points to it,
otherwise returns NIL."
  (with-foreign-string (ident-foreign name)
     (let ((foreign-value
	    (%rf-find-var (%rf-install ident-foreign) *r-global-env*)))
       (if (r-bound foreign-value)
	   foreign-value
	 nil))))

(def-function ("Rf_getAttrib" %rf-get-attrib)
  ((robj sexp)
   (attrib sexp))
  :returning sexp)

(def-function ("Rf_setAttrib" %rf-set-attrib)
  ((robj sexp)
   (attrib sexp)
   (val sexp))
  :returning sexp)

(def-r-var "R_NamesSymbol" *r-names-symbol*)
(def-r-var "R_DimSymbol" *r-dims-symbol*)

;;; Basic conversions

(def-function ("LOGICAL" %LOGICAL)
  ((e sexp))
  :returning (* :int))

(def-function ("INTEGER" %INT)
  ((e sexp))
  :returning (* :int))

(def-function ("REAL" %REAL)
  ((e sexp))
  :returning (* :double))
  
;; (DEFUN %REAL (E)
;;   (ALIEN:WITH-ALIEN ((%REAL (FUNCTION (* C-CALL:DOUBLE) SEXP) :EXTERN "REAL"))
;;                     (VALUES (ALIEN:ALIEN-FUNCALL %REAL E))))


;;; The complex type
(def-struct r-complex
  (r :double)
  (i :double))

(def-function ("COMPLEX" %COMPLEX)
  ((e sexp))
  :returning (* 'r-complex))

;;; String handling.
(def-function ("Rf_mkChar" %rf-mkchar)
  ((s foreign-string))
  :returning sexp)

(def-function ("SET_STRING_ELT" %set-string-elt)
  ((robj sexp)
   (i :int)
   (string sexp))
  :returning :void)

(def-function ("STRING_ELT" %string-elt)
  ((s sexp)
   (i :int))
  :returning sexp)

(def-function ("R_CHAR" %r-char)
  ((s sexp))
  :returning foreign-string)

;;; Basic Conversion Routines

(defun robj-to-int (robj &optional (i 0))
  "Returns the integer inside an R object.  Assumes it's an
integral robj.  Converts NA's"
  (let ((result (deref-array (%INT robj) :int i)))
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
  (deref-array (%real robj) :double i))

	    
(defun robj-to-complex (robj &optional (i 0))
  "Returns the complex number inside an R object.  Assumes it's a
complex robj."
  (let ((complex (deref-array (%COMPLEX robj) 'r-complex i)))
    (complex (uffi::get-direct-value complex 'r-complex 'r)
	     (uffi::get-direct-value complex 'r-complex 'i))))

(defun robj-to-string (robj &optional (i 0))
  "Convert an R object to a string.  Assumes it's a string robj."
  (convert-from-foreign-string (%r-char (%string-elt robj i))))

;;; Helpers

(def-function ("doubleFloatVecToR" %double-float-vec-to-R)
    ((d (* :double))
     (i :int)
     (s sexp))
  :returning :void)

(def-function ("intVecToR" %integer-vec-to-R)
    ((d (* :int))
     (i :int)
     (s sexp)
     (div :int))
  :returning :void)

     

;;; Sequence and (eventually) Dictionary Conversions

(defconstant +int-seq+ 1)
(defconstant +float-seq+ 2)
(defconstant +complex-seq+ 3)
(defconstant +string-seq+ 4)
(defconstant +any-seq+ 0)

(defconstant +seq-fsm+ #2A((0 0 0 0 0)
			   (0 1 2 3 0)
			   (0 2 2 3 0)
			   (0 3 3 3 0)
			   (0 0 0 0 4)))

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
    (let ((robj (%rf-protect (%rf-alloc-vector sexptype#vecsxp len)))
	  (state (type-to-int (elt seq 0)))
	  (i 0))
      (typecase seq 
	((simple-array double-float)
	 (%double-float-vec-to-R (system:vector-sap seq) len robj))
;; 	 (map nil
;; 	      (lambda (e)
;; 		(%set-vector-elt robj i (double-float-to-robj e))
;; 		(incf i))
;; 	      seq))
	((simple-array fixnum)
	 (%integer-vec-to-R (system:vector-sap seq) len robj 4))
	(t 
	 (map nil
	      (lambda (e)
		(%set-vector-elt robj i (convert-to-r e))
		(setf state (aref +seq-fsm+ state (type-to-int e))
		      i     (+ i 1)))
	      seq)))
      (let ((result
	     (case state
	       (#.+int-seq+ (%rf-coerce-vector robj sexptype#intsxp))
	       (#.+float-seq+ (%rf-coerce-vector robj sexptype#realsxp))
	       (#.+complex-seq+ (%rf-coerce-vector robj sexptype#cplxsxp))
	       (#.+string-seq+ (%rf-coerce-vector robj sexptype#strsxp))
	       (t robj))))
	(%rf-unprotect 1)
	(values result state)))))


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
  (let ((robj (%rf-alloc-vector sexptype#lglsxp 1)))
    (setf (deref-pointer (%LOGICAL robj) :int)
	  1)
    robj))


(defun int-to-robj (n)
  "Returns an R object corresponding to an integer."
  (let ((robj (%rf-alloc-vector sexptype#intsxp 1)))
    (setf (deref-pointer (%INT robj) :int) n)
    robj))


(defun float-to-robj (f)
  "Returns an R object corresponding to a floating point number.  Coerces
the number to double-float."
  (double-float-to-robj (coerce f 'double-float)))


(defun double-float-to-robj (d)
  "Returns an R object corresponding to a floating point number.  Coerces
the number to double-float."
  (let ((robj (%rf-alloc-vector sexptype#realsxp 1)))
    (setf (deref-pointer (%real robj) :double) d)
    robj))

(defun complex-to-robj (c)
  "Returns an R object corresponding to a CL complex number.  Coerces the
real and imaginary points to double-float."
  (let ((robj (%rf-alloc-vector sexptype#cplxsxp 1)))
    (let ((complex (deref-pointer (%COMPLEX robj) 'r-complex)))
;;       (setf (get-slot-value complex 'r-complex 'r) (coerce (realpart c) 'double-float)
;; 	    (get-slot-value complex 'r-complex) 'i) (coerce (imagpart c) 'double-float)))
      (setf (alien:slot complex 'r) (coerce (realpart c) 'double-float)
	    (alien:slot complex 'i) (coerce (imagpart c) 'double-float)))
    robj))

(defun string-to-robj (string)
  "Convert a string to an R object."
  (let ((robj (%rf-alloc-vector sexptype#strsxp 1))
        (str-sexp
	 (with-foreign-string (s string)
           (%rf-mkchar s))))
    (%set-string-elt robj 0 str-sexp)
    robj))

(defun array-to-robj (a)
  "Convert an array to an R object."
  (let ((column-vector 
	 (convert-to-r (array-to-vec-column-major a))))
    (%rf-set-attrib column-vector 
		    *r-dims-symbol* 
		    (convert-to-r (array-dimensions a)))
    column-vector))

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
    (#.sexptype#intsxp 'integer) ;;; Sigh, not fixnum.
    (#.sexptype#lglsxp 'boolean)
    (#.sexptype#realsxp 'double-float)
    (#.sexptype#cplxsxp 'complex)
    (#.sexptype#strsxp 'string)
    (#.sexptype#listsxp 't)
    (#.sexptype#vecsxp 't)
    (t (error "Unknown type"))))

(defun convert-from-r-seq (robj length)
  "Convert an r-sequence into CL."
  (let* ((type (sexptype robj))
	 (result (make-array length :element-type (sexptype-to-element-type type))))
    (dotimes (i length)
      (setf (aref result i)
	    (case type
	      (#.sexptype#intsxp (robj-to-int robj i))
	      (#.sexptype#lglsxp (robj-to-logical robj i))
	      (#.sexptype#realsxp (robj-to-double robj i))
	      (#.sexptype#cplxsxp (robj-to-complex robj i))
	      (#.sexptype#strsxp (robj-to-string robj i))
	      (#.sexptype#listsxp (convert-from-r (%rf-elt robj i)))
	      (#.sexptype#vecsxp (convert-from-r (%vector-elt robj i)))
	      (t (error "Unknown type")))))
    (values result type)))
  
(defmacro get-name (symbol-or-string)
  (if (stringp symbol-or-string)
      symbol-or-string
    (string-downcase (symbol-name symbol-or-string))))
   
(eval-when (:compile-toplevel :load-toplevel)
  (defparameter *backconvert* t)
  )


(defun to-list (seq)
  (map 'list #'identity seq))

(defun to-vector (seq)
  (map 'vector #'identity seq))


(defmacro r-convert (&body body)
  (let ((*backconvert* t)) ;; Compile time
    `(let ((*backconvert* t)) ;; Run time
      ,@body)))

(defmacro r-do-not-convert (&body body)
  (let ((*backconvert* nil))   ;; Compile time
    `(let ((*backconvert* nil))  ;; Run time
      ,@body)))

(defmacro with-r-args ((name &rest arglist) &body body)
  `(let ((,name (get-r-args ,@arglist)))
     (unwind-protect 
	 (multiple-value-prog1 ,@body)
       (unprotect-args ,name))))

(defmacro r (name &rest args)
  "The primary user interface to rclg.  Converts all the arguments into
R objects.  Does not backconvert nested calls to R, so a call like
r sum (r seq 1 10)) should DTRT."
  (with-gensyms (r-args evaled result names dims)
   `(with-r-args (,r-args ,@args)
     (let ((,evaled (%rf-protect (r-call (get-name ,name) ,r-args))))	 
       (update-r)
       ,(if *backconvert*
	    `(let ((,result (convert-from-r ,evaled))
		   (,names (r-names ,evaled))
		   (,dims (r-dims ,evaled)))
	      (%rf-unprotect 1) ;; evaled
	      (values (if ,dims (reshape-array ,result ,dims) ,result)
	       ,names))
	    `(make-instance 'sexp-holder :sexp ,evaled :protected t))))))


(defmacro get-r-args (&rest args)
  `(r-do-not-convert
    (list ,@(mapcar (lambda (a)
		      (if (keywordp a) 
			  `,a
			  `(%rf-protect (convert-to-r ,a))))
		    args))))

(defun unprotect-args (args)
  (map nil (lambda (a) (unless (keywordp a) (%rf-unprotect-ptr a))) args))

(defun r-call (name args)
  "Does the actual call to R.  The args must be a list of raw
R objetcs.  Returns an unprotected, unconverted R object."
  (let ((func (get-from-name name)))
    (if (not func)
	(error "Cannot find function ~A" name)      
	(let ((func (%rf-protect func))
	      (exp (%rf-protect 
		    (%rf-alloc-vector sexptype#langsxp (sexp-length args)))))
	  (r-setcar exp func)
	  (%rf-unprotect 1)  ;; func
	  (parse-args (r-cdr exp) args)
	  (r-eval exp)))))

(defun get-r-error ()
  (r-convert 
    (r geterrmessage)))

(defun parse-args (exp args)
  (do ((arglist args (cdr arglist)))
      ((null arglist) nil)
    (let ((cur (car arglist)))
      (if (keywordp cur)
	  (progn
	    (parse-keyword exp cur (cadr arglist))
	    (setf arglist (cdr arglist)))
	(parse-regular-arg exp cur))
      (with-cast-pointer (r-cur exp 'sexprec)
	 (setf exp (r-cdr r-cur))))))

(defun parse-keyword (exp kwd arg)
  (with-cast-pointer (p exp 'sexprec)
     (r-setcar p arg)
     (with-foreign-string (f (string-downcase (symbol-name kwd)))
	(%set-tag p (%rf-install f)))))

(defun parse-regular-arg (exp arg)
  (with-cast-pointer (p exp 'sexprec)
     (r-setcar p arg)))

(defmacro over-column-major-indices ((array cmi rmi) &body body)
  (with-gensyms (n index dims update-index dim d index-param)
    `(let* ((,n (array-total-size ,array))
	    (,dims (to-vector (array-dimensions ,array)))
	    (,d (array-rank ,array))
	    (,index (to-list (make-array ,d :initial-element 0))))
       (labels ((,update-index (,index-param ,dim)
		   (incf (car ,index-param))
		   (when (= (car ,index-param) (aref ,dims ,dim))
		     (setf (car ,index-param) 0)
		     (when (< ,dim (- ,d 1))
		       (,update-index (cdr ,index-param) (+ ,dim 1))))))
	 (dotimes (,rmi ,n)
	   (let ((,cmi (apply #'array-row-major-index ,array ,index)))
	     ,@body
	     (,update-index ,index 0)))))))
  
(defun reshape-array (old-array dims)
  (let ((result (make-array (to-list dims) :element-type (array-element-type old-array))))
    (over-column-major-indices (result cmi rmi)
       (setf (row-major-aref result cmi) (aref old-array rmi)))
    result))

(defun array-to-vec-column-major (array)
  (let ((result (make-array (array-total-size array) :element-type (array-element-type array))))
    (over-column-major-indices (array cmi rmi)
	(setf (aref result rmi) (row-major-aref array cmi)))
    result))

(defun sexp-length (args)
  (+ 1 (length args) (- (count-keywords args))))

(defun count-keywords (args)
  (count-if #'keywordp args))

(defun r-names (robj)  
  (let ((names (%rf-get-attrib robj *r-names-symbol*)))
    (if (r-nil names)
	nil
      (convert-from-r names))))

(defun r-dims (robj)
  (let ((dims (%rf-get-attrib robj *r-dims-symbol*)))
    (if (r-nil dims)
	nil
	(convert-from-r dims))))


;;; Event handling

(def-foreign-type input-handler-ptr (* :void))
(def-foreign-type fd-mask (* :void))

(def-foreign-var ("R_InputHandlers" *r-input-handlers*) input-handler-ptr "R")


(def-function ("R_checkActivity" %r-check-activity)
  ((usec :int)
   (ignore-stdin :int))
  :returning fd-mask)

(def-function ("R_runHandlers" %r-run-handlers)
  ((i input-handler-ptr)
   (f fd-mask))
  :returning :void)

;;; Primarily for updating graphics
(defun update-R ()
  (%r-run-handlers *r-input-handlers*
		   (%r-check-activity 10000 0)))


(defun remove-plist (plist &rest keys)
  "Remove the keys from the plist.
Useful for re-using the &REST arg after removing some options."
  (do (copy rest)
      ((null (setq rest (nth-value 2 (get-properties plist keys))))
       (nreconc copy plist))
    (do () ((eq plist rest))
      (push (pop plist) copy)
      (push (pop plist) copy))
    (setq plist (cddr plist))))

(defun to-keyword (symbol)
  (intern (symbol-name symbol) :keyword))

(defun atom-or-first (val)
  (if (atom val)
      val
    (car val)))

(defmacro def-r-call ((macro-name r-name conversion &rest required-args) 
		      &rest keyword-args)
  (let* ((rest-sym (gensym "rest"))
	 (result-sym (gensym "result"))
	 (keyword-names (mapcar #'atom-or-first keyword-args))
	 (keywords (mapcar #'to-keyword keyword-names)))
    `(defmacro ,macro-name (,@required-args 
			    &rest ,rest-sym 
			    &key ,@keyword-args
			    &allow-other-keys)
       `(let ((,',result-sym
	       (r-do-not-convert 
		(r ,',r-name 
		   ,,@required-args
		   ,,@(mapcan #'(lambda (k n) (list k n)) 
			      keywords 
			      keyword-names)
		   ,@(remove-plist ,rest-sym ,@keywords)))))
	  (declare (ignorable ,',result-sym))
	  ,',(case conversion
	      (:convert `(r-convert ,result-sym))
	      (:raw `,result-sym)
	      (:no-result nil)
	      (t (error "Unknown value of conversion: ~A" conversion)))))))

;; This is necessary because CMU's traps modes cause error upon
;; R startup.
#+cmu
(eval-when (:load-toplevel)
  (let ((current-traps (cadr (member :traps (ext:get-floating-point-modes)))))
    (when (find :invalid current-traps)
      (progn
	(warn "WARNING: removing :invalid from floating-point-modes traps.")
	(ext:set-floating-point-modes :traps 
				      (remove :invalid current-traps))))))


(eval-when (:load-toplevel)
  (start-r))

#+cmu
(eval-when (:load-toplevel)
  (mp:make-process (lambda () (do () (nil) (progn (update-r) (sleep 0.1))))))

(defmacro uffi::get-slot-value (obj type slot)
  `(alien:slot ,obj ,slot))
