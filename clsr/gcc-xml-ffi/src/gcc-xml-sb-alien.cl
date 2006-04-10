
(in-package :gcc-xml-ffi)

;;; FIXME -- CLH 2005-08-24
;;;
;;; This is a hack to get around the fact that in SBCL
;;; we can't declare an alien-callback that returns type
;;; :void unless sb-alien::*values-type-okay* is t.
;;;
;;; CLH: this should no longer be necessary on SBCL 0.9.5.64 and later
;(eval-when (:compile-toplevel :load-toplevel :execute)
;  (setf sb-alien::*values-type-okay* t))

(defparameter *c-to-sb-alien-type-hash-table* (make-hash-table :test 'equal))

(defparameter *null-char-ptr* (sb-alien:make-alien sb-alien:char 0))
(defparameter *null-unsigned-char-ptr* (sb-alien:make-alien sb-alien:unsigned-char 0))

(defmacro %macro-convert-to-alien-string (str &key (signed))
  (let ((type (if signed
                  'sb-alien:char
                  'sb-alien:unsigned-char)))
    `(progn
       (declare (optimize (speed 3) (safety 0)))
       (typecase ,str
         (simple-string
          (let ((a (sb-alien:make-alien ,type (the fixnum (1+ (the fixnum (length ,str)))))))
            (declare (type (sb-alien:alien (* ,type)) a))
            (dotimes (i (length ,str))
              (declare (type fixnum i))
              (setf (sb-alien:deref a i) (char-code (aref ,str i))))
            (setf (sb-alien:deref a (length ,str)) 0)
            a))))))

(declaim (inline %convert-to-alien-string))
(defun %convert-to-alien-string (str a)
  (declare (type (sb-alien:alien (* sb-alien:unsigned-char)) a))
  (dotimes (i (length str))
    (declare (type fixnum i))
    (setf (sb-alien:deref a i) (char-code (aref str i))))
  (setf (sb-alien:deref a (length str)) 0)
  a)
  
(defun convert-to-alien-string (str)
  (declare (optimize (speed 3) (safety 0)))
  (typecase str
    (null *null-unsigned-char-ptr*)
    (simple-string
     (let ((a (sb-alien:make-alien sb-alien:unsigned-char (the fixnum (1+ (the fixnum (length str)))))))
       (%convert-to-alien-string str a)))))

(declaim (inline %convert-to-alien-signed-string))
(defun %convert-to-alien-signed-string (str a)
  (declare (type (sb-alien:alien (* sb-alien:char)) a))
  (dotimes (i (length str))
    (declare (type fixnum i))
    (setf (sb-alien:deref a i) (char-code (aref str i))))
  (setf (sb-alien:deref a (length str)) 0)
  a)
  
(defun convert-to-alien-signed-string (str)
  (declare (optimize (speed 3) (safety 0)))
  (typecase str
    (null *null-char-ptr*)
    (simple-string
     (let ((a (sb-alien:make-alien sb-alien:char (the fixnum (1+ (the fixnum (length str)))))))
       (%convert-to-alien-signed-string str a)))))

(declaim (inline %convert-to-alien-pascal-string))
(defun %convert-to-alien-pascal-string (str pstr)
;;  (declare (type (sb-alien:alien (* sb-alien:unsigned-char)) pstr))
  (setf (sb-alien:deref pstr 0) (length str)) 
  (do ((i 1 (incf i)))
      ((> i (length str)) pstr)
    (setf (sb-alien:deref pstr i) (char-code (elt str (1- i)))))
  pstr)
  
(defun convert-to-alien-pascal-string (str)
  (declare (optimize (speed 3) (safety 0)))
  (typecase str
    (null *null-unsigned-char-ptr*)
    (simple-string
     (let ((a (sb-alien:make-alien sb-alien:unsigned-char (the fixnum (1+ (the fixnum (length str)))))))
       (%convert-to-alien-pascal-string str a)))))

(declaim (inline free-alien-string))
(defun free-alien-string (a)
  (sb-alien:free-alien a))

(declaim (inline convert-from-alien-string))
(defun convert-from-alien-string (a)
  (sb-alien:cast a sb-alien:utf8-string))

(defun convert-from-alien-pascal-string (pstr)
  (coerce
   (mapcar #'code-char
           (let ((len (sb-alien:deref pstr 0)))
             (loop for i from 1 to len
                collect (sb-alien:deref pstr i))))
   'string))

(defmacro with-alien-string ((alien string) &body body)
  `(let ((,alien (convert-to-alien-string ,string)))
     (unwind-protect
          (progn
            ,@body)
       (when ,alien (free-alien-string ,alien)))))
   
(defmacro with-alien-signed-string ((alien string) &body body)
  `(let ((,alien (convert-to-alien-signed-string ,string)))
     (unwind-protect
          (progn
            ,@body)
       (when ,alien (free-alien-string ,alien)))))

(defmacro with-alien-pascal-string ((alien string) &body body)
  `(let ((,alien (convert-to-alien-pascal-string ,string)))
     (unwind-protect
          (progn
            ,@body)
       (when ,alien (free-alien-string ,alien)))))
   
(mapcar #'(lambda (x) (setf (gethash (car x) *c-to-sb-alien-type-hash-table*) (cdr x)))
	'(("char" . sb-alien:char)
	  ("signed char" . sb-alien:char)
	  ("bool" . (sb-alien:boolean 8))
	  ("unsigned char" . sb-alien:unsigned-char)
	  ("short" . sb-alien:short)
	  ("short int" . sb-alien:short)
	  ("unsigned short" . sb-alien:unsigned-short)
	  ("short unsigned int" . sb-alien:unsigned-short)
	  ("int" . sb-alien:int)
	  ("wchar_t" . sb-alien:int)

	  ("unsigned int" . sb-alien:unsigned-int)
	  ("long" . sb-alien:long)
	  ("long int" . sb-alien:long)
	  ("long long int" . (sb-alien:integer 64))

	  ("unsigned long int" . sb-alien:unsigned-long)
	  ("long unsigned int" . sb-alien:unsigned-long)
	  ("long long unsigned int" . (sb-alien:integer 64))

	  ("float" . sb-alien:float)
	  ("double" . sb-alien:double)

	  ;;; FIXME The SB-ALIEN type for long double is probably wrong!
	  ("long double" . sb-alien:double)

	  ;;; FIXME The SB-ALIEN type for complex double is probably wrong!
	  ("complex double" . sb-alien:double)

	  ;;; FIXME The SB-ALIEN type for complex long double is probably wrong!
	  ("complex long double" . sb-alien:double)

	  ;;; FIXME The SB-ALIEN type for complex float is probably wrong!
	  ("complex float" . sb-alien:double)

	  ("void" . sb-alien:void)

	  ;;; Special case for pointer to void - which SB-ALIEN wants as an atomic type
	  ;;; FIXME this is surely wrong
	  ("pointer void" . (* t))))

(defun get-sb-alien-type-from-c-type (c-type)
  (gethash c-type *c-to-sb-alien-type-hash-table*))

(defun get-sb-alien-type-from-id (id decls)
  (let ((c-type (gethash id (c-ids decls))))
    (typecase c-type
      (c-pointer-type
       (let ((data-type (get-sb-alien-type-from-id (type-id c-type)
					       decls))
	     (pointed-type (gethash (type-id c-type) (c-ids decls))))
	 (cond
	   ;; We need to treat void pointers specially for SB-ALIEN to be happy
	   ((eql data-type 'sb-alien:void)
	    (get-sb-alien-type-from-c-type "pointer void"))
	   (t
	    (typecase pointed-type
	      (c-function
	       (get-sb-alien-type-from-c-type "pointer void"))
	      (c-function-type
	       (get-sb-alien-function-type decls pointed-type))
	      (c-class
	       (get-sb-alien-type-from-c-type "pointer void"))
	      (t `(* ,data-type)))))))
      (c-struct
       `(sb-alien:struct ,(intern (ffi-symbol-case (name c-type)))))
      (c-union
       `(sb-alien:union ,(intern (ffi-symbol-case (name c-type)))))
      (c-array-type
       (let ((element-type (gethash (type-id c-type) (c-ids decls))))
	 (let ((element-sb-alien-type
		(typecase element-type
		  (c-function-type
		   (get-sb-alien-type-from-c-type "pointer void"))
		  (t
		   (get-sb-alien-type-from-id (type-id c-type) decls)))))
	   `(sb-alien:array ,element-sb-alien-type
		    ,(1+ (read-number-from-string (array-type-max c-type)))))))
      (c-typedef
       (let ((pointed-type (gethash (type-id c-type) (c-ids decls))))
	 (typecase pointed-type
	   (c-function-type
	    (get-sb-alien-type-from-c-type "pointer void"))
	   (t
	    (get-sb-alien-type-from-id (type-id c-type) decls)))))
      (c-cv-qualified-type 
       (get-sb-alien-type-from-id (type-id c-type) decls))
      (c-reference-type 
       (get-sb-alien-type-from-id (type-id c-type) decls))
      (c-enumeration
       (intern (ffi-symbol-case (name c-type))))
      (c-fundamental-type
       (get-sb-alien-type-from-c-type (name c-type)))
      (c-function-type
       (get-sb-alien-type-from-c-type "pointer void")))))

(defun get-function-arg-name (arg pos)
  (if (slot-boundp arg 'name)
      (intern (name arg))
      (get-nth-arg-label pos)))

(defgeneric make-sb-alien-declaration (decls c-decl ancestors))
(defgeneric %make-sb-alien-declaration (decls c-decl))
(defgeneric %make-forward-sb-alien-declaration (decls c-decl))

(defmethod make-sb-alien-declaration :before (decls (obj id-mixin) ancestors)
  (set-type-status (id obj) decls +type-requested+))

(defmethod make-sb-alien-declaration :after (decls (obj id-mixin) ancestors)
  (set-type-status (id obj) decls +type-declared+))

(defmethod make-sb-alien-declaration (decls decl ancestors)
  nil)

(defmethod %make-forward-sb-alien-declaration (decls decl)
  nil)

(defun make-sb-alien-declaration-from-id (decls id ancestors)
  (let ((decl (gethash id (c-ids decls))))
    (make-sb-alien-declaration decls decl ancestors)))

(defun make-forward-sb-alien-declaration-from-id (decls id ancestors)
  (let ((decl (gethash id (c-ids decls))))
    (%make-forward-sb-alien-declaration decls decl)))

(defun maybe-make-sb-alien-declaration-from-id (decls id ancestors)
;;  (print (list 'maybe id (check-type-declared id decls)))
  (unless (check-type-declared id decls)
    (make-sb-alien-declaration-from-id decls id ancestors)))

(defun maybe-make-forward-sb-alien-declaration-from-id (decls id ancestors)
;;  (print (list 'maybe id (check-type-declared id decls)))
  (unless (check-type-forward-declared id decls)
    (make-forward-sb-alien-declaration-from-id decls id ancestors)))

;;;
;;; c-cv-qualified-type
(defmethod make-sb-alien-declaration (decls (cv-qual-type c-cv-qualified-type) ancestors)
;;;  (print (cons 'cv-qualified-type-required (get-required-types cv-qual-type)))
  (let ((sb-alien-decls))
    (dolist (id (get-required-types cv-qual-type))
      (let ((q (maybe-make-sb-alien-declaration-from-id decls id (cons cv-qual-type ancestors))))
	(if q (push q sb-alien-decls))))
    (if sb-alien-decls
	(list* 'cl:progn ;;; (list 'print "pointer-forward")
	       (reverse sb-alien-decls)))))

;;;
;;; c-reference-type
(defmethod make-sb-alien-declaration (decls (ref-type c-reference-type) ancestors)
;;;  (print (cons 'reference-type-required (get-required-types ref-type)))
  (let ((sb-alien-decls))
    (dolist (id (get-required-types ref-type))
      (let ((q (maybe-make-sb-alien-declaration-from-id decls id (cons ref-type ancestors))))
	(if q (push q sb-alien-decls))))
    (if sb-alien-decls
	(list* 'cl:progn ;;; (list 'print "pointer-forward")
	       (reverse sb-alien-decls)))))

;;;
;;; c-pointer-type
(defmethod make-sb-alien-declaration (decls (ptr-type c-pointer-type) ancestors)
;;;  (print (cons 'pointer-required (get-required-types ptr-type)))
  (let ((sb-alien-decls))
    ;; we point to a c-struct or c-union, we don't need to chase the type
    ;; yet! I think...
    (dolist (id (get-required-types ptr-type))
      (let ((parent (car ancestors)))
        (unless (and parent
                     (or (subtypep (class-of parent) 'c-union)
                         (subtypep (class-of parent) 'c-struct)))
                     (let ((q (maybe-make-sb-alien-declaration-from-id decls id (cons ptr-type ancestors))))
            (if q (push q sb-alien-decls))))))
    (if sb-alien-decls
	(list* 'cl:progn ;;; (list 'print "pointer-forward")
	       (reverse sb-alien-decls)))))

(defmethod make-sb-alien-declaration (decls (nspc c-namespace) ancestors)
  (when *verbose*
      (list 'format t (format nil "Namespace ~A not yet implemented~~%"
			      (if (slot-boundp nspc 'name)
				  (name nspc)
				  nil)))))

(defmethod make-sb-alien-declaration (decls (ctor c-constructor) ancestors)
  (when *verbose*
    (list 'format t (format nil "Constructor ~A not yet implemented~~%"
			    (if (slot-boundp ctor 'name)
				(name ctor)
				nil)))))

(defmethod make-sb-alien-declaration (decls (class c-class) ancestors)
  (when *verbose*
    (list 'format t (format nil "Class ~A not yet implemented~~%"
			    (if (slot-boundp class 'name)
				(name class)
				nil)))))



(defmethod %make-sb-alien-declaration (decls (var c-variable))
  (let* ((n (name var))
	 (i (intern (ffi-symbol-case n))))
    (list 'sb-alien:define-alien-variable (list n i)
	  (get-sb-alien-type-from-id (type-id var) decls))))

(defmethod make-sb-alien-declaration (decls (var c-variable) ancestors)
  (let ((sb-alien-decls))
    (dolist (id (get-required-types var))
      (let ((q (maybe-make-sb-alien-declaration-from-id decls id (cons var ancestors))))
	(if q (push q sb-alien-decls))))
    (if sb-alien-decls
	(list* 'cl:progn ;;; (list 'print (list 'list "typedef" (name var)))
	       (append (reverse sb-alien-decls)
		       (list (%make-sb-alien-declaration decls var))))
	(%make-sb-alien-declaration decls var))))


(defmethod %make-sb-alien-declaration (decls (tdef c-typedef))
  ;; FIXME: if the type is sb-alien:void, don't spit out a
  ;; typedef. this is a hack but there are some issues with.  jsnell
  ;; submitted an SBCL patch that was supposed to fix this, but it
  ;; doesn't work yet. Revisit when SBCL is fixed to allow
  ;; define-alien-typ'ing a type to be sb-alien:void.
  (let ((type (get-sb-alien-type-from-id (type-id tdef) decls)))
    (unless (equal type 'sb-alien:void)
      (list 'sb-alien:define-alien-type (intern (ffi-symbol-case (name tdef)))
	    type))))

(defmethod make-sb-alien-declaration (decls (tdef c-typedef) ancestors)
  (let ((sb-alien-decls))
    (dolist (id (get-required-types tdef))
      (let ((q (maybe-make-sb-alien-declaration-from-id decls id (cons tdef ancestors))))
	(if q (push q sb-alien-decls))))
    (if sb-alien-decls
	(list* 'cl:progn ;;; (list 'print (list 'list "typedef" (name tdef)))
	       (append (reverse sb-alien-decls)
		       (list (%make-sb-alien-declaration decls tdef))))
	(%make-sb-alien-declaration decls tdef))))

(defmethod make-sb-alien-declaration (decls (array-type c-array-type) ancestors)
  (let ((sb-alien-decls))
    (dolist (id (get-required-types array-type))
      (let ((q (maybe-make-sb-alien-declaration-from-id decls id (cons array-type ancestors))))
	(if q (push q sb-alien-decls))))
    (when sb-alien-decls
	(list* 'cl:progn ;;; (list 'print (list 'list "array-type" (name array-type)))
	       (reverse sb-alien-decls)))))

;;; FIXME! There is a bug that prevents certain alien declarations
;;; from working right when loading from a fasl, so we have to load
;;; them using "load". I commented this out in hopes of working around
;;; this problem, but it doesn't seem to help. Perhaps this should go
;;; back in.
(defmethod %make-forward-sb-alien-declaration (decls (struc c-struct)) 
  ;;   (let ((symbol (intern (ffi-symbol-case (name struc)))))
  ;;     `(sb-alien:define-alien-type
  ;;          ,symbol (sb-alien:struct ,symbol)))
  )

(defun guess-alignment-from-offset (offset)
  (cond ((zerop offset) 8)
        ((zerop (mod offset 64)) 64)
        ((zerop (mod offset 32)) 32)
        ((zerop (mod offset 16)) 16)
        ((zerop (mod offset 8)) 8)
        (t 1)))

(defmethod %make-sb-alien-declaration (decls (struc c-struct))
  (let ((name (intern (ffi-symbol-case (name struc)))))
    (append
     (list 'sb-alien:define-alien-type name
           (cons 'sb-alien:struct
                 (cons name
                       (loop for member-id in (members struc)
                          append (let ((member (gethash member-id (c-ids decls))))
                                   (typecase member
                                     (c-field
                                      (list
                                       (append
                                        (list (intern (ffi-symbol-case (name member))))
                                        (list (get-sb-alien-type-from-id
                                               (type-id member) decls))
                                        (when (offset member)
                                          `(:alignment ,(guess-alignment-from-offset (offset member))))))))))))))))

(defmethod make-sb-alien-declaration :around (decls (struc c-struct) ancestors)
;;  (print (cons 'ape (get-type-status (id struc) decls)))
  (cond 
    ((equal (get-type-status (id struc) decls) +type-undeclared+)
     (set-type-status (id struc) decls +type-requested+)
     (let ((sb-alien-decls))
       (dolist (id (get-required-types struc))
         (let ((req-decl (gethash id (c-ids decls))))
           (unless (and (subtypep (type-of req-decl) 'c-field) 
                        (pointer-type-p decls (gethash (type-id req-decl) (c-ids decls))))
             (let ((q (maybe-make-sb-alien-declaration-from-id decls id (cons struc ancestors))))
               (if q (push q sb-alien-decls))))))
       (prog1
	   (if sb-alien-decls
	       (list* 'cl:progn ;;; (list 'print (list 'list "struct" (name struc)))
		      (append (reverse sb-alien-decls)
			      (list (%make-sb-alien-declaration decls struc))))
	       (%make-sb-alien-declaration decls struc))
	 (set-type-status (id struc) decls +type-declared+))))
;    ((equal (get-type-status (id struc) decls) +type-requested+)
;     (%make-forward-sb-alien-declaration decls struc))
    (t nil)))

(defmethod %make-forward-sb-alien-declaration (decls (u c-union))
  (let ((symbol (intern (ffi-symbol-case (name u)))))
    `(sb-alien:define-alien-type
         ,symbol (sb-alien:union ,symbol))))

;;; check to see if this is a poitner type or a typedef to a pointer type

(defun pointer-type-p (decls type)
  (typecase type
    (c-pointer-type t)
    (c-typedef
     (pointer-type-p decls (gethash (type-id type) (c-ids decls))))
    (t nil)))

(defmethod %make-sb-alien-declaration (decls (u c-union))
  (let ((name (intern (ffi-symbol-case (name u)))))
    (append (list 'sb-alien:define-alien-type
                  name
                  (cons 'sb-alien:union
                        (cons name
                              (loop for member-id in (members u)
                                 append (let ((member (gethash member-id (c-ids decls))))
                                          (typecase member
                                            (c-field
                                             (list
                                              (list (intern (ffi-symbol-case (name member)))
                                                    (get-sb-alien-type-from-id
                                                     (type-id member) decls)))))))))))))

(defmethod make-sb-alien-declaration :around (decls (u c-union) ancestors)
;;  (print (cons 'ape (get-type-status (id u) decls)))
  (cond 
    ((equal (get-type-status (id u) decls) +type-undeclared+)
     (set-type-status (id u) decls +type-requested+)
     (let ((sb-alien-decls))
       (dolist (id (get-required-types u))
         (unless (pointer-type-p decls (gethash id (c-ids decls)))
           (let ((q (maybe-make-sb-alien-declaration-from-id decls id (cons u ancestors))))
             (if q (push q sb-alien-decls)))))
       (prog1
	   (if sb-alien-decls
	       (list* 'cl:progn ;;; (list 'print (list 'list "union" (name u)))
		      (append (reverse sb-alien-decls)
			      (list (%make-sb-alien-declaration decls u))))
	       (%make-sb-alien-declaration decls u))
	 (set-type-status (id u) decls +type-declared+))))
    ((equal (get-type-status (id u) decls) +type-requested+)
     (%make-forward-sb-alien-declaration decls u))
    (t nil)))


(defmethod make-sb-alien-declaration :around (decls (field c-field) ancestors)
  (cond 
    ((equal (get-type-status (id field) decls) +type-undeclared+)
     (set-type-status (id field) decls +type-requested+)
     (let* ((id (type-id field))
            (req (gethash id (c-ids decls))))
;       (print (list 'moose req ancestors))
;       (if (pointer-type-p decls req)
;           (progn (print 'did-it) nil)
           (prog1
               (maybe-make-sb-alien-declaration-from-id decls id (cons field ancestors))
             (set-type-status (id field) decls +type-declared+))))
;)
    (t nil)))

(defmethod %make-sb-alien-declaration (decls (func c-function))
  (let* ((n (name func))
	 (i (intern (ffi-symbol-case n))))
    (append (list 'sb-alien:define-alien-routine (list n i)
		  (get-sb-alien-type-from-id (function-returns func) decls))
	    (loop for arg in (function-arguments func)
	       for j from 1
	       collect (list (get-function-arg-name arg j)
			     (get-sb-alien-type-from-id (type-id arg) decls))))))

(defmethod make-sb-alien-declaration (decls (func c-function) ancestors)
;;;  (print (cons 'function-required (get-required-types func)))
  (unless (and *skip-gcc-builtin-functions*
               (slot-exists-p func 'name)
               (slot-boundp func 'name)
               (eq (search "__builtin" (name func)) 0))
    (let ((sb-alien-decls))
      (dolist (id (get-required-types func))
        (let ((q (maybe-make-sb-alien-declaration-from-id decls id (cons func ancestors))))
          (if q (push q sb-alien-decls))))
      (if sb-alien-decls
          (list* 'cl:progn
                 (append (reverse sb-alien-decls)
                         (list `(declaim
                                 (inline ,(intern (ffi-symbol-case (name func))))))
                         (list (%make-sb-alien-declaration decls func))))
          (list 'cl:progn
                `(declaim
                  (inline ,(intern (ffi-symbol-case (name func)))))
                (%make-sb-alien-declaration decls func))))))

(defmethod get-sb-alien-function-type (decls (func-type c-function-type))
  `(* (sb-alien:function 
       ,(get-sb-alien-type-from-id (function-returns func-type) decls)
       .
       ,(loop for arg in (function-arguments func-type)
           for j from 1
           collect (get-sb-alien-type-from-id (type-id arg) decls)))))

(defmethod make-sb-alien-declaration (decls (c-func-type c-function-type) ancestors)
;;;  (print (cons 'c-function-type-required (get-required-types c-func)))
  (let ((sb-alien-decls))
    (dolist (id (get-required-types c-func-type))
      (let ((q (maybe-make-sb-alien-declaration-from-id decls id (cons c-func-type ancestors))))
	(if q (push q sb-alien-decls))))
    (if sb-alien-decls
	(list* 'cl:progn ;;; (list 'print "pointer-forward")
	       (reverse sb-alien-decls)))))

(defmethod %make-sb-alien-declaration (decls (enum c-enumeration))
  (list*
   'cl:progn
   (list 'sb-alien:define-alien-type 
         (intern (ffi-symbol-case (name enum)))
         (list* 'sb-alien:enum
                nil
                (reverse
                 (loop for val in (enumeration-values enum)
                    collect (typecase val
                              (c-enum-value (list
                                              (intern (ffi-symbol-case (name val)))
                                              (read-number-from-string
                                               (enum-value-init val)))))))))
   (reverse
    (loop for val in (enumeration-values enum)
       collect
         (cons 'defparameter
               (typecase val
                 (c-enum-value (list
                                (intern (ffi-symbol-case (name val)))
                                (read-number-from-string
                                 (enum-value-init val))))))))))

(defmethod make-sb-alien-declaration (decls (enum c-enumeration) ancestors)
  (let ((sb-alien-decls))
    (dolist (id (get-required-types enum))
      (let ((q (maybe-make-sb-alien-declaration-from-id decls id (cons enum ancestors))))
	(if q (push q sb-alien-decls))))
    (if sb-alien-decls
	(list* 'cl:progn ;;; (list 'print (list 'list "enum" (name enum)))
	       (reverse sb-alien-decls)
               (%make-sb-alien-declaration decls enum))
	(%make-sb-alien-declaration decls enum))))


#|
(defmethod make-sb-alien-declaration (decls (enum c-enumeration))
  `(cl:progn
     ,(list 'sb-alien:define-alien-type
	    (intern (ffi-symbol-case (name enum))) 'sb-alien:int)
     ,@(reverse
	(loop for val in (enumeration-values enum)
	   collect (typecase val
		     (c-enum-value (list
				    'defconstant
				    (intern (ffi-symbol-case
					     (concatenate 'string
							  (name enum)
							  "#"
							  (name val))))
				    (read-number-from-string
				     (enum-value-init val)))))))))
  
|#



;;;;
;;;;
;;;;

(defun write-sb-alien-declarations (decls stream)
  (clrhash *numbered-args*)
  (dolist (id (sorted-hash-table-ids (c-ids decls)))
    (unless (gethash id (declared-ids decls))
      (let ((ancestors))
        (let ((decl (make-sb-alien-declaration decls (gethash id (c-ids decls)) ancestors)))
          (when decl
            (print decl stream)
            (set-type-status id decls +type-finalized+))))))
  (terpri stream))

(defun write-sb-alien-declarations-to-file (decls path &key package)
  (with-open-file (defout path :direction :output :if-exists :supersede)
    (when package
      (print `(in-package ,(intern (string-upcase (package-name package)) :keyword)) defout)
      (terpri defout))
    (write-sb-alien-declarations decls defout)))

