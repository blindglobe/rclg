;;;
;;; file: clsr-sxp.cl
;;; author: cyrus harmon
;;;

(in-package :clsr)

(declaim (ftype (function
                 ((sb-alien:alien (sb-alien:* (SB-ALIEN:STRUCT
                                               R::|SEXPREC|)))) t)
                r-sexp-to-lisp-sexp))
(declaim (notinline r-sexp-to-lisp-sexp))

;;;; R SEXP Conversion Routines
;;;;
;;;; These routines convert R sexps to corresponding lisp sexps.

;;;; This bit of the Rinternals.h defines the known R SEXP types:

#|
typedef unsigned int SEXPTYPE;

#define NILSXP	     0	  /* nil = NULL */
#define SYMSXP	     1	  /* symbols */
#define LISTSXP	     2	  /* lists of dotted pairs */
#define CLOSXP	     3	  /* closures */
#define ENVSXP	     4	  /* environments */
#define PROMSXP	     5	  /* promises: [un]evaluated closure arguments */
#define LANGSXP	     6	  /* language constructs (special lists) */
#define SPECIALSXP   7	  /* special forms */
#define BUILTINSXP   8	  /* builtin non-special forms */
#define CHARSXP	     9	  /* "scalar" string type (internal only)*/
#define LGLSXP	    10	  /* logical vectors */
#define INTSXP	    13	  /* integer vectors */
#define REALSXP	    14	  /* real variables */
#define CPLXSXP	    15	  /* complex variables */
#define STRSXP	    16	  /* string vectors */
#define DOTSXP	    17	  /* dot-dot-dot object */
#define ANYSXP	    18	  /* make "any" args work.
			     Used in specifying types for symbol
			     registration to mean anything is okay  */
#define VECSXP	    19	  /* generic vectors */
#define EXPRSXP	    20	  /* expressions vectors */
#define BCODESXP    21    /* byte code */
#define EXTPTRSXP   22    /* external pointer */
#define WEAKREFSXP  23    /* weak reference */
#define RAWSXP      24    /* raw bytes */
|#

;;;; We maintain a hashtable from SEXPTYPEs to the appropriate lisp
;;;; conversion routines. At some point, we will undoubtedly need to
;;;; go the other way to convert from lisp sexps to R sexps, but this
;;;; is not there yet.


;;; SXP Attributes
(defun levels (sxp)
  (let ((factors (r::|Rf_getAttrib| sxp r::|R_LevelsSymbol|)))
    (r-sexp-to-lisp-sexp factors)))

(defun get-attrib (sxp symbol)
  (let ((attr (r::|Rf_getAttrib| sxp symbol)))
    (r-sexp-to-lisp-sexp attr)))

(defun dim (sxp) 
  (let ((attr (r::|Rf_getAttrib| sxp r::|R_DimSymbol|)))
    (r-sexp-to-lisp-sexp attr)))

(defun names (sxp) (get-attrib sxp r::|R_NamesSymbol|))
(defun row-names (sxp) (get-attrib sxp r::|R_RowNamesSymbol|))
(defun mode (sxp) (get-attrib sxp r::|R_ModeSymbol|))



;;; 0 - NILSXP - just use (constantly nil) in the appropriate place in
;;; the hashtables


;;; 1 - SYMSXP - Symbols
;;; For the moment just return the PRINTNAME of the symsxp. There's
;;; more stuff here, but ignore it until we figure out whether or not
;;; we need it.

(defun symsxp-to-list (sxp)
  "Converts an R symbol to a list with the lisp symbol R-SYMBOL
 and the printame of the symbol"
  (declare (type (sb-alien:alien (sb-alien:* (SB-ALIEN:STRUCT
                                              R::|SEXPREC|))) sxp))
  (list 'r-symbol
        (r-sexp-to-lisp-sexp (r::|PRINTNAME| sxp))))

;;; 2 - LISTSXP - Dotted pair lists (bona fide lists :-))
;;; Just recursively build a list of the r::|CAR| and r::|CDR| of the
;;; list

(defun listsxp-to-list (sxp)
  "Convert an R dotted pair list to a lisp list"
  (cons (r-sexp-to-lisp-sexp (r::|CAR| sxp))
        (r-sexp-to-lisp-sexp (r::|CDR| sxp))))

;;; 3 - CLOSXP - Closure
;;; For the moment, just return a list with the sexps of the formals,
;;; the bodys and the closure's environment. Not the nicest way to
;;; handle this.
;;; FIXME! How should we represent closures on the lisp side???
(defun closxp-to-list (sxp)
  "Convert an R closure to a lisp list that describes this closure"
  (list (r::|FORMALS| sxp)
        (r::|BODY| sxp)
        (r::|CLOENV| sxp)))

;;; 4 - ENVSXP
;;; FIXME!!!! Add support for mapping an environment to hash table!
(defun envsxp-to-list (sxp)
  (list 'r-env))
;        (r-sexp-to-lisp-sexp (r::|FRAME| sxp))
;        (r-sexp-to-lisp-sexp (r::|ENCLOS| sxp))
;        (r-sexp-to-lisp-sexp (r::|HASHTAB| sxp))))

;;; 5 - PROMSXP
;;; FIXME! What do I do with these?

;;; 6 - LANGSXP 
;;; I think these are just dotted pair lists, so use listsxp-to-list
;;; for now

;;; 7 - SPECIALSXP - ???
;;; FIXME!! Um... what are these?

;;; 8 - BUILTINSXP - ???
;;; FIXME!! Um... what are these?

;;; 9 - CHARSXP
;;; convert from alien string to lisp string
(defun charsxp-to-string (sxp)
  "Converts an R charsxp (an internal R string) to a lisp string"
  (gcc-xml-ffi::convert-from-alien-string (r::|R_CHAR| sxp)))

;;; Vector SXPs


(macrolet ((def-sxp-accessors (name r-type-fun lisp-type)
             `(progn
                (eval-when (:compile-toplevel :load-toplevel :execute)
                  (declaim (inline ,name (setf ,name)))
                  (declaim (ftype (function (r-sexp fixnum) ,lisp-type) ,name))
                  (declaim (ftype (function (,lisp-type r-sexp fixnum) ,lisp-type) (setf ,name))))
                (defun ,name (sxp i)
                  (declare (type fixnum i)
                           (type r-sexp sxp))
                  (locally (declare (optimize (speed 3) (space 0) (safety 0)))
                    (sb-alien:deref (,r-type-fun sxp) i)))
                (defun (setf ,name) (val sxp i)
                  (declare (type fixnum i)
                           (type ,lisp-type val)
                           (type r-sexp sxp))
                  (locally (declare (optimize (speed 3) (space 0) (safety 0)))
                    (setf (sb-alien:deref (,r-type-fun sxp) i) val))))))

  ;; 10 LGLSXP - Vector of logicals
  (def-sxp-accessors lglsxp-element r::|LOGICAL| (unsigned-byte 1))

  ;; 13 INTSXP - Vector of intergers
  (def-sxp-accessors intsxp-element r::|INTEGER| integer)

  ;; 14 REALSXP - Vector of Reals
  (def-sxp-accessors realsxp-element r::|REAL| double-float)

  )

;;; Additional Vector SXP Utility Functions

;; 10 LGLSXP - Vector of logicals
  (defun lglsxp-to-bit (sxp &key (start 0) (end (1- (r::|LENGTH| sxp))))
  "Converts an R vector of logicals (T/F) to a vector of lisp bits"
  (let* ((v (make-array (1+ (- end start)) :element-type 'bit)))
    (declare (type (simple-array bit (*)) v))
    (loop for i from start to end
       do (setf (aref v i) (lglsxp-element sxp i)))
    v))

;;; 13 INTSXP - Vector of intergers
(defun intsxp-factor (sxp i)
  (let ((factors (r::|Rf_getAttrib| sxp r::|R_LevelsSymbol|)))
    (strsxp-element factors (1- (intsxp-element sxp i)))))

(defun intsxp-element-or-factor (sxp i)
  (cond ((eql (r::|Rf_isFactor| sxp) 'R::TRUE) ;; it's a factor
         (intsxp-factor sxp i))
        (t
         (intsxp-element sxp i))))

(defun intsxp-to-integer (sxp &key (start 0) (end (1- (r::|LENGTH| sxp))))
  "Converts an R vector of integers to a vector of lisp integers"
  (cond ((eql (r::|Rf_isFactor| sxp) 'R::TRUE) ;; it's a factor
         (let* ((v (make-array (1+ (- end start))))
                (factors (r::|Rf_getAttrib| sxp r::|R_LevelsSymbol|)))
           (loop for i from start to end
              do (setf (aref v i)
                       (strsxp-element factors (1- (intsxp-element sxp i)))))
           v))
        ;; The type of the lisp vector could probably be more specific here,
        ;; like (signed-byte 32), but I'm not sure that's right.
        (t (let* ((v (make-array (1+ (- end start)) :element-type 'integer)))
             (declare (type (simple-array integer (*)) v))
             (loop for i from start to end
                do (setf (aref v i) (intsxp-element sxp i)))
             v))))

;;; 14 - REALSXP
;; (defun realsxp-element (sxp i)
;;  (sb-alien:deref (r::|REAL| sxp) i))
;;  
;; (defun (setf realsxp-element) (val sxp i)
;;  (setf (sb-alien:deref (r::|REAL| sxp) i) val))
  
;;; The type of the lisp vector could probably be more specific here,
;;; like double-float, but I'm not sure that's right, so leave as Real
;;; and see what happens.
(defun realsxp-to-real (sxp)
  "Converts an R vector of integers to a vector of lisp reals"
  (let* ((l (r::|LENGTH| sxp))
         (v (make-array l :element-type 'real)))
    (declare (type (simple-array real (*)) v))
    (dotimes (i l)
      (setf (aref v i) (realsxp-element sxp i)))
    v))


;;; Helper funciton to convert a single R complex value (as opposed to
;;; a CPLXSXP -- which is a vector of complexes) into a lisp complex.
;;; Make this inline so that it goes quickly.
(declaim (inline r-complex))
(declaim (ftype (function (r-complex) complex) r-complex))
(defun r-complex (c)
  "Convert an R complex into a lisp complex"
  (declare (type r-complex c))
  (complex (sb-alien:slot c 'r::|r|)
           (sb-alien:slot c 'r::|i|)))

;;; Helper function to set the value of an existing R complex number
;;; to the value of a lisp complex. Note that this is not a lisp -> R
;;; conversion 
(declaim (inline (setf r-complex)))
(declaim (ftype (function (complex r-complex) complex) (setf r-complex)))
(defun (setf r-complex) (lc c)
  "sets an R complex to the value of the lisp complex"
  (declare (type r-complex c))
  (setf (sb-alien:slot c 'r::|r|) (realpart lc)
        (sb-alien:slot c 'r::|i|) (imagpart lc))
  lc)

(defun cplxsxp-element (sxp i)
  (let ((c (sb-alien:deref (r::|COMPLEX| sxp) i)))
    (r-complex c)))
  
(defun (setf cplxsxp-element) (val sxp i)
  (setf (r-complex (sb-alien:deref (r::|COMPLEX| sxp) i)) val))
  
(defun cplxsxp-to-complex (sxp)
  "Converts an R vector of complex numbers to a vector of lisp complexes"
  (let* ((l (r::|LENGTH| sxp))
         (v (make-array l :element-type '(or complex (integer 0 0)))))
    (declare (type (simple-array complex (*)) v)
             (type (sb-alien:alien (sb-alien:* (SB-ALIEN:STRUCT R::|SEXPREC|))) sxp))
    (dotimes (i l)
        (setf (aref v i) (cplxsxp-element sxp i)))
    v))

;;; 16 - STRSXP
;;; convert from alien string to lisp string
(defun strsxp-element (sxp i)
  (let ((type (r::|TYPEOF| (r::|VECTOR_ELT| sxp i))))
    (cond ((equal type r::|CHARSXP|)
           (charsxp-to-string (r::|VECTOR_ELT| sxp i))))))

;;; need setf here!
(defun (setf strsxp-element) (val sxp i)
  (gcc-xml-ffi::with-alien-signed-string (val-alien val)
    (r::|SET_STRING_ELT| sxp i (r::|Rf_mkChar| val-alien))))

(defun strsxp-to-vector (sxp)
  "Converts an R vector of strings to a vector of lisp strings"
  (let* ((l (r::|LENGTH| sxp))
         (v (make-array l
                        :element-type '(or null (simple-array character (*)))
                        :initial-element nil)))
    (declare (type (simple-array * (*)) v))
    (dotimes (i l)
      (setf (aref v i) (strsxp-element sxp i)))
    v))

(defclass rsxp-ref () ((sxp :accessor sxp :initarg :sxp)))
(defclass nilsxp-ref (rsxp-ref) ())
(defclass symsxp-ref (rsxp-ref) ())
(defclass listsxp-ref (rsxp-ref) ())
(defclass closxp-ref (rsxp-ref) ())
(defclass envsxp-ref (rsxp-ref) ())
(defclass langsxp-ref (rsxp-ref) ())
(defclass charsxp-ref (rsxp-ref) ())
(defclass lglsxp-ref (rsxp-ref) ())
(defclass intsxp-ref (rsxp-ref) ())
(defclass realsxp-ref (rsxp-ref) ())
(defclass cplxsxp-ref (rsxp-ref) ())
(defclass strsxp-ref (rsxp-ref) ())
(defclass vecsxp-ref (rsxp-ref) ())

(defparameter *r-sexp-class-hash*
  (ch-util:make-hash-table-from-alist
   `((,r::|NILSXP| . nilsxp-ref)
     (,r::|SYMSXP| . symsxp-ref)
     (,r::|LISTSXP| . listsxp-ref)
     (,r::|CLOSXP| . closxp-ref)
     (,r::|ENVSXP| . envsxp-ref)
     (,r::|LANGSXP| . listsxp-ref)
     (,r::|CHARSXP| . charsxp-ref)
     (,r::|LGLSXP| . lglsxp-ref)
     (,r::|INTSXP| . intsxp-ref)
     (,r::|REALSXP| . realsxp-ref)
     (,r::|CPLXSXP| . cplxsxp-ref)
     (,r::|STRSXP| . strsxp-ref)
     (,r::|VECSXP| . vecsxp-ref))
   :test #'equal)
  "Hash-table of routines to convert R s-expressions to lisp
  s-expressions")

(defun r-sxp-ref-class (sxp)
  (gethash (r::|TYPEOF| sxp) *r-sexp-class-hash*))

(defun r-sxp-ref (sxp)
  (let ((class (r-sxp-ref-class sxp)))
    (if class
        (make-instance class :sxp sxp)
        (error 'r-error :details "Unable to find class for r-sxp"))))

(defmethod preserve-sxp ((ref rsxp-ref))
  (r::|R_PreserveObject| (sxp ref)))

(defmethod release-sxp ((ref rsxp-ref))
  (r::|R_ReleaseObject| (sxp ref)))

(defmethod sxp-ref-length ((ref rsxp-ref))
  (r::|Rf_length| (sxp ref)))

(defgeneric sxp-ref-element (ref index))
(defgeneric (setf sxp-ref-element) (val ref index))

(defmethod sxp-ref-element ((ref lglsxp-ref) i)
  (lglsxp-element (sxp ref) i))

(defmethod (setf sxp-ref-element) (val (ref lglsxp-ref) i)
  (setf (lglsxp-element (sxp ref) i) val))

(defmethod sxp-ref-element ((ref intsxp-ref) i)
  (intsxp-element (sxp ref) i))

(defmethod (setf sxp-ref-element) (val (ref intsxp-ref) i)
  (setf (intsxp-element (sxp ref) i) val))

(defmethod sxp-ref-element ((ref realsxp-ref) i)
  (realsxp-element (sxp ref) i))

(defmethod (setf sxp-ref-element) (val (ref realsxp-ref) i)
  (setf (realsxp-element (sxp ref) i) val))

(defmethod sxp-ref-element ((ref cplxsxp-ref) i)
  (cplxsxp-element (sxp ref) i))

(defmethod (setf sxp-ref-element) (val (ref cplxsxp-ref) i)
  (setf (cplxsxp-element (sxp ref) i) val))

(defmethod sxp-ref-element ((ref strsxp-ref) i)
  (strsxp-element (sxp ref) i))

(defmethod (setf sxp-ref-element) (val (ref strsxp-ref) i)
  (setf (strsxp-element (sxp ref) i) val))

(defclass data-frame (rsxp)
  ((dimensions :accessor df-dim :initarg :dimensions)
   (names :accessor df-names :initarg :names)
   (row-names :accessor df-row-names :initarg :row-names)
   (data :accessor df-data :initarg :data)))

(defun make-data-frame (sxp)
  (let ((dim (dim sxp))
        (names (names sxp))
        (row-names (row-names sxp)))
    (let* ((l (r::|LENGTH| sxp))
           (v (make-array (list (length row-names) l))))
      (declare (type (simple-array * (* *)) v))
      (dotimes (i l)
        (let ((elt (r::|VECTOR_ELT| sxp i)))
          (dotimes (j (length row-names))
            (setf (aref v j i) (r-vector-sexp-element elt j)))))
      (make-instance 'data-frame :dimensions dim :names names :row-names row-names :data v))))

(defun vecsxp-element (sxp i)
  (r-sexp-to-lisp-sexp (r::|VECTOR_ELT| sxp i)))

(defun vecsxp-to-vector (sxp)
  "Convert an R vector to a lisp (untyped) vector "
  (cond
    ((eql (r::|Rf_isFrame| sxp) 'R::TRUE)
     (make-data-frame sxp))
    (t 
     (let* ((l (r::|LENGTH| sxp))
            (v (make-array l)))
       (declare (type (simple-array * (*)) v))
       (dotimes (i l)
         (setf (aref v i) (vecsxp-element sxp i)))
       v))))

(defparameter *r-sexp-conversion-hash*
  (ch-util:make-hash-table-from-alist
   `((,r::|NILSXP| . ,(constantly nil))
     (,r::|SYMSXP| . symsxp-to-list)
     (,r::|LISTSXP| . listsxp-to-list)
     (,r::|CLOSXP| . closxp-to-list)
     (,r::|ENVSXP| . envsxp-to-list)
     (,r::|LANGSXP| . listsxp-to-list)
     (,r::|CHARSXP| . charsxp-to-string)
     (,r::|LGLSXP| . lglsxp-to-bit)
     (,r::|INTSXP| . intsxp-to-integer)
     (,r::|REALSXP| . realsxp-to-real)
     (,r::|CPLXSXP| . cplxsxp-to-complex)
     (,r::|STRSXP| . strsxp-to-vector)
     (,r::|VECSXP| . vecsxp-to-vector))
   :test #'equal)
  "Hash-table of routines to convert R s-expressions to lisp
  s-expressions")

(defun r-sexp-conversion-function (sxp)
  (gethash (r::|TYPEOF| sxp) *r-sexp-conversion-hash*))

;;; we're going to assume that 
(defun r-sexp-to-lisp-sexp (sxp)
  "Converts an R s-expression to a lisp s-expression, based on the
  type of the R s-expression"
  (unless (sb-alien:null-alien sxp)
    (let ((fun (r-sexp-conversion-function sxp)))
      (if fun
          (funcall fun sxp)
          (warn "unknown R SEXP type ~A" (r::|TYPEOF| sxp))))))

(defparameter *r-vector-sexp-element-conversion-hash*
  (ch-util:make-hash-table-from-alist
   `((,r::|LGLSXP| . lglsxp-element)
     (,r::|INTSXP| . intsxp-element)
     (,r::|REALSXP| . realsxp-element)
     (,r::|CPLXSXP| . cplxsxp-element)
     (,r::|STRSXP| . strsxp-element)
     (,r::|VECSXP| . vecsxp-element))
   :test #'equal)
  "Hash-table of routines to convert elements of R vectors to
  lisp data objects")

(defun r-vector-sexp-element (sxp i)
  (let ((fun (gethash (r::|TYPEOF| sxp) *r-vector-sexp-element-conversion-hash*)))
    (if fun
        (funcall fun sxp i)
        (warn "unknown R SEXP type ~A" (r::|TYPEOF| sxp)))))

(defun r-make-ext-ptr-sxp-from-callback (callback)
  "makes an R SXP that is an EXTPTRSXP that points to a lisp
callback"
  (let ((extp (r::|Rf_allocSExp| r::|EXTPTRSXP|))
        (funp (sb-alien::alien-sap callback))
        ;; it would be more efficient to cache native symbol, but we
        ;; can't build this until after R has been initialized
        (native-symbol
         (gcc-xml-ffi::with-alien-signed-string (sym "native symbol")
           (r::|Rf_install| sym))))
    (r::|R_SetExternalPtrAddr| extp funp)
    (r::|R_SetExternalPtrTag| extp native-symbol)
    extp))
