
(in-package :gcc-xml-ffi)

(uffi:def-type unsigned-char-ptr (* :unsigned-char))
(uffi:def-type char-ptr (* :char))

(defun convert-to-foreign-string (str)
  (declare (optimize (speed 3) (safety 0) (space 0)))
  (declare (type simple-string str))
  (let ((l (length str)))
    (declare (type fixnum l))
    (let ((fstr (uffi:allocate-foreign-object :unsigned-char (1+ l))))
      (declare (type unsigned-char-ptr fstr))
      (setf (uffi:deref-array fstr :unsigned-char l) 0)
      (do ((i 0 (incf i)))
	  ((= i l) fstr)
	(declare (fixnum i))
	(setf (uffi:deref-array fstr :unsigned-char i) (char-code (elt str i)))))))

(defun convert-to-foreign-signed-string (str)
  (declare (optimize (speed 3) (safety 0)))
  (declare (type simple-string str))
  (let* ((l (length str))
	 (fstr (uffi:allocate-foreign-object :char (1+ l))))
    (declare (type fixnum l)
	     (type char-ptr fstr))
    (setf (uffi:deref-array fstr :char l) 0)
    (do ((i 0 (incf i)))
	((= i l) fstr)
      (declare (fixnum i))
      (setf (uffi:deref-array fstr :char i) (char-code (elt str i))))))

(defmacro with-foreign-signed-string ((foreign-string lisp-string) &body body)
  (let ((result (gensym)))
    `(let* ((,foreign-string (convert-to-foreign-signed-string ,lisp-string))
	    (,result (progn ,@body)))
      (declare (dynamic-extent ,foreign-string))
      (uffi:free-foreign-object ,foreign-string)
      ,result)))

(defparameter *c-to-uffi-type-hash-table* (make-hash-table :test 'equal))
(mapcar #'(lambda (x) (setf (gethash (car x) *c-to-uffi-type-hash-table*) (cdr x)))
	'(("char" . :char)
	  ("signed char" . :char)
	  ("bool" . :char)
	  ("unsigned char" . :unsigned-char)
	  ("short" . :short)
	  ("short int" . :short)
	  ("unsigned short" . :unsigned-short)
	  ("short unsigned int" . :unsigned-short)
	  ("int" . :int)
	  ("wchar_t" . :int)

	  ("unsigned int" . :unsigned-int)
	  ("long int" . :long)
	  ("long long int" . :long)
	  ;;; FIXME The UFFI type for long long is probably wrong!

	  ("unsigned long int" . :unsigned-long)
	  ("long unsigned int" . :unsigned-long)
	  ("long long unsigned int" . :unsigned-long)
	  ;;; FIXME The UFFI type for long long is probably wrong!

	  ("float" . :float)
	  ("double" . :double)
	  ;;; FIXME The UFFI type for long double is probably wrong!
	  ("long double" . :double)

	  ;;; FIXME The UFFI type for complex double is probably wrong!
	  ("complex double" . :double)

	  ;;; FIXME The UFFI type for complex long double is probably wrong!
	  ("complex long double" . :double)

	  ;;; FIXME The UFFI type for complex float is probably wrong!
	  ("complex float" . :double)

	  ("void" . :void)
	  ;;; Special case for pointer to void - which UFFI wants as an atomic type
	  ("pointer void" . :pointer-void)))

(defun get-uffi-type-from-c-type (c-type)
  (gethash c-type *c-to-uffi-type-hash-table*))

(defun get-uffi-type-from-id (id decls)
  (let ((c-type (gethash id (c-ids decls))))
    (typecase c-type
      (c-pointer-type
       (let ((data-type (get-uffi-type-from-id (type-id c-type)
					       decls))
	     (pointed-type (gethash (type-id c-type) (c-ids decls))))
	 (cond
	   ;; We need to treat void pointers specially for UFFI to be happy
	   ((eql data-type :void)
	    (get-uffi-type-from-c-type "pointer void"))
	   ;; And we need to check for pointers to functions and
	   ;; declare them as void because UFFI doesn't handle
	   ;; function pointers, AFAICT.
	   (t
	    (typecase pointed-type
	      (c-function
	       (get-uffi-type-from-c-type "pointer void"))
	      (c-function-type
	       (get-uffi-type-from-c-type "pointer void"))
	      (c-class
	       (get-uffi-type-from-c-type "pointer void"))
	      (t `(* ,data-type)))))))
      (c-struct
       `(:struct ,(intern (ffi-symbol-case (name c-type)))))
      (c-union
       `(:union ,(intern (ffi-symbol-case (name c-type)))))
      (c-array-type
       (let ((element-type (gethash (type-id c-type) (c-ids decls))))
	 (let ((element-uffi-type
		(typecase element-type
		  (c-function-type
		   (get-uffi-type-from-c-type "pointer void"))
		  (t
		   (get-uffi-type-from-id (type-id c-type) decls)))))
	   `(:array ,element-uffi-type
		    ,(1+ (read-number-from-string (array-type-max c-type)))))))
      (c-typedef
       (let ((pointed-type (gethash (type-id c-type) (c-ids decls))))
	 (typecase pointed-type
	   (c-function-type
	    (get-uffi-type-from-c-type "pointer void"))
	   (t
	    (get-uffi-type-from-id (type-id c-type) decls)))))
      (c-cv-qualified-type 
       (get-uffi-type-from-id (type-id c-type) decls))
      (c-enumeration
       :int) ;;; arguably this should be the name of the c-enumeration
      (c-fundamental-type
       (get-uffi-type-from-c-type (name c-type)))
      (c-function-type
       (get-uffi-type-from-c-type "pointer void")))))

(defgeneric make-uffi-declaration (decls c-decl))
(defgeneric %make-uffi-declaration (decls c-decl))

(defmethod make-uffi-declaration :before (decls (obj id-mixin))
  (set-type-status (id obj) decls +type-requested+))

(defmethod make-uffi-declaration :after (decls (obj id-mixin))
  (set-type-status (id obj) decls +type-declared+))

(defun make-uffi-declaration-from-id (decls id)
  (let ((decl (gethash id (c-ids decls))))
    (make-uffi-declaration decls decl)))

(defun maybe-make-uffi-declaration-from-id (decls id)
;;  (print (list 'maybe id (check-type-declared id decls)))
  (unless (check-type-declared id decls)
    (make-uffi-declaration-from-id decls id)))

(defmethod make-uffi-declaration (decls obj)
  (when *verbose* (list 'format t (format nil "Found unknown Element: ~A~~%" obj))))

(defmethod make-uffi-declaration (decls (ptr-type c-pointer-type))
;;;  (print (cons 'pointer-required (get-required-types ptr-type)))
  (let ((uffi-decls))
    (dolist (id (get-required-types ptr-type))
      (let ((q (maybe-make-uffi-declaration-from-id decls id)))
	(if q (push q uffi-decls))))
    (if uffi-decls
	(list* 'progn ;;; (list 'print "pointer-forward")
	       (reverse uffi-decls)))))

(defmethod make-uffi-declaration (decls (nspc c-namespace))
  (when *verbose*
      (list 'format t (format nil "Namespace ~A not yet implemented~~%"
			      (if (slot-boundp nspc 'name)
				  (name nspc)
				  nil)))))

(defmethod make-uffi-declaration (decls (ctor c-constructor))
  (when *verbose*
    (list 'format t (format nil "Constructor ~A not yet implemented~~%"
			    (if (slot-boundp ctor 'name)
				(name ctor)
				nil)))))

(defmethod make-uffi-declaration (decls (class c-class))
  (when *verbose*
    (list 'format t (format nil "Class ~A not yet implemented~~%"
			    (if (slot-boundp class 'name)
				(name class)
				nil)))))

;; (defmethod make-uffi-declaration (decls (variable c-variable))
;;   (when *verbose*
;;     (list 'format t (format nil "Variable ~A not yet implemented~~%"
;; 			    (if (slot-boundp variable 'name)
;; 				(name variable)
;; 				nil)))))

(defmethod %make-uffi-declaration (decls (var c-variable))
  (let* ((n (name var))
	 (i (intern (ffi-symbol-case n))))
    (list 'uffi:def-foreign-var (list n i)
	  (get-uffi-type-from-id (type-id var) decls) nil)))

(defmethod make-uffi-declaration (decls (var c-variable))
  (let ((uffi-decls))
    (dolist (id (get-required-types var))
      (let ((q (maybe-make-uffi-declaration-from-id decls id)))
	(if q (push q uffi-decls))))
    (if uffi-decls
	(list* 'progn ;;; (list 'print (list 'list "typedef" (name var)))
	       (append (reverse uffi-decls)
		       (list (%make-uffi-declaration decls var))))
	(%make-uffi-declaration decls var))))


(defmethod %make-uffi-declaration (decls (tdef c-typedef))
  (list 'uffi:def-foreign-type (intern (ffi-symbol-case (name tdef)))
	(get-uffi-type-from-id (type-id tdef) decls)))

(defmethod make-uffi-declaration (decls (tdef c-typedef))
  (let ((uffi-decls))
    (dolist (id (get-required-types tdef))
      (let ((q (maybe-make-uffi-declaration-from-id decls id)))
	(if q (push q uffi-decls))))
    (if uffi-decls
	(list* 'progn ;;; (list 'print (list 'list "typedef" (name tdef)))
	       (append (reverse uffi-decls)
		       (list (%make-uffi-declaration decls tdef))))
	(%make-uffi-declaration decls tdef))))

(defgeneric %make-forward-uffi-declaration (decls struc))

(defmethod %make-forward-uffi-declaration (decls (struc c-struct))
  (list 'uffi:def-struct
	(intern (ffi-symbol-case (name struc)))))

(defmethod %make-uffi-declaration (decls (struc c-struct))
  (append (list 'uffi:def-struct
		(intern (ffi-symbol-case (name struc))))
	  (loop for member-id in (members struc)
	     append (let ((member (gethash member-id (c-ids decls))))
		      (typecase member
			(c-field
			 (list
			  (list (intern (ffi-symbol-case (name member)))
				(get-uffi-type-from-id
				 (type-id member) decls)))))))))

(defmethod make-uffi-declaration :around (decls (struc c-struct))
;;  (print (cons 'ape (get-type-status (id struc) decls)))
  (cond 
    ((equal (get-type-status (id struc) decls) +type-undeclared+)
     (set-type-status (id struc) decls +type-requested+)
     (let ((uffi-decls))
       (dolist (id (get-required-types struc))
	 (let ((q (maybe-make-uffi-declaration-from-id decls id)))
	   (if q (push q uffi-decls))))
       (prog1
	   (if uffi-decls
	       (list* 'progn ;;; (list 'print (list 'list "struct" (name struc)))
		      (append (reverse uffi-decls)
			      (list (%make-uffi-declaration decls struc))))
	       (%make-uffi-declaration decls struc))
	 (set-type-status (id struc) decls +type-declared+))))
    ((equal (get-type-status (id struc) decls) +type-requested+)
     (%make-forward-uffi-declaration decls struc))
    (t nil)))

;; FIXME! Add in :pointer-self trick to above (and below)!!!

(defmethod %make-forward-uffi-declaration (decls (union c-union))
  (list 'uffi:def-union
	(intern (ffi-symbol-case (name union)))))

(defmethod %make-uffi-declaration (decls (union c-union))
  (append (list 'uffi:def-union
		(intern (ffi-symbol-case (name union))))
	  (loop for member-id in (members union)
	     append (let ((member (gethash member-id (c-ids decls))))
		      (typecase member
			(c-field
			 (list
			  (list (intern (ffi-symbol-case (name member)))
				(get-uffi-type-from-id
				 (type-id member) decls)))))))))

(defmethod make-uffi-declaration :around (decls (union c-union))
;;  (print (cons 'ape (get-type-status (id union) decls)))
  (cond 
    ((equal (get-type-status (id union) decls) +type-undeclared+)
     (set-type-status (id union) decls +type-requested+)
     (let ((uffi-decls))
       (dolist (id (get-required-types union))
	 (let ((q (maybe-make-uffi-declaration-from-id decls id)))
	   (if q (push q uffi-decls))))
       (prog1
	   (if uffi-decls
	       (list* 'progn ;;; (list 'print (list 'list "union" (name union)))
		      (append (reverse uffi-decls)
			      (list (%make-uffi-declaration decls union))))
	       (%make-uffi-declaration decls union))
	 (set-type-status (id union) decls +type-declared+))))
    ((equal (get-type-status (id union) decls) +type-requested+)
     (%make-forward-uffi-declaration decls union))
    (t nil)))

(defmethod make-uffi-declaration (decls (enum c-enumeration))
  (append (list 'uffi:def-enum
		(intern (ffi-symbol-case (name enum))))
	  (list
	   (loop for val in (enumeration-values enum)
	      append (typecase val
		       (c-enum-value (list
				      (list (intern (ffi-symbol-case (name val)))
					    (read-number-from-string
					     (enum-value-init val))))))))))

(defmethod make-uffi-declaration (decls (cvqt c-cv-qualified-type))
  (let ((uffi-decls))
    (dolist (id (get-required-types cvqt))
      (let ((q (maybe-make-uffi-declaration-from-id decls id)))
	(if q (push q uffi-decls))))
    (if uffi-decls
	(list* 'progn ;;; (list 'print (list 'list "cv-qualified-type" (id cvqt)))
	       (reverse uffi-decls)))))

(defmethod make-uffi-declaration (decls (func c-function-type))
  (let ((uffi-decls))
    (dolist (id (get-required-types func))
      (let ((q (maybe-make-uffi-declaration-from-id decls id)))
	(if q (push q uffi-decls))))
    (if uffi-decls
	(list* 'progn ;;; (list 'print "function-type")
	       (reverse uffi-decls)))))

(defmethod make-uffi-declaration (decls (fund c-fundamental-type))
  (if (slot-boundp fund 'name)
      (unless (get-uffi-type-from-c-type (name fund))
	(list 'format t (format nil "Unknown FundamentalType ~A~~%" (name fund))))
      (list 'format t (format nil "Unknown FundamentalType ~A~~%" nil))))

;;; No UFFI declarations necessary for enum-vals
(defmethod make-uffi-declaration (decls (enum-val c-enum-value))
  nil)

;;; No UFFI declarations necessary for fields
(defmethod make-uffi-declaration (decls (field c-field))
  (let ((uffi-decls))
    (dolist (id (get-required-types field))
      (let ((q (maybe-make-uffi-declaration-from-id decls id)))
	(if q (push q uffi-decls))))
    (if uffi-decls
	(list* 'progn ;;; (list 'print (list 'list "field" (name field)))
	       (reverse uffi-decls)))))

;;; No UFFI declarations necessary for array types
;;; This is not true! May need to declare array element type
(defmethod make-uffi-declaration (decls (atyp c-array-type))
  (let ((element-id (type-id atyp)))
    (unless (check-type-declared element-id decls)
      (make-uffi-declaration decls (get-decl-from-id element-id decls)))))

(defmethod make-uffi-declaration (decls (arg c-argument))
  (format t "Argument should not appear at top level~%"))

(defmethod %make-uffi-declaration (decls (func c-function))
  (let* ((n (name func))
	 (i (intern (ffi-symbol-case n))))
    (list 'uffi:def-function (list n i)
	  (loop for arg in (function-arguments func)
	     for j from 1
	     collect (list (get-nth-arg-label j)
			   (get-uffi-type-from-id (type-id arg) decls)))
	  :returning 
	  (progn
	    (get-uffi-type-from-id (function-returns func) decls)))))

(defmethod make-uffi-declaration (decls (func c-function))
;;;  (print (cons 'function-required (get-required-types func)))
  (unless (and *skip-gcc-builtin-functions*
               (slot-exists-p func 'name)
               (slot-boundp func 'name)
               (eq (search "__builtin" (name func)) 0))
    (let ((uffi-decls))
      (dolist (id (get-required-types func))
        (let ((q (maybe-make-uffi-declaration-from-id decls id)))
          (if q (push q uffi-decls))))
      (if uffi-decls
          (list* 'progn
                 (append (reverse uffi-decls)
                         (list (%make-uffi-declaration decls func))))
          (%make-uffi-declaration decls func)))))

(defun write-uffi-declarations (decls stream)
  (dolist (id (sorted-hash-table-ids (c-ids decls)))
    (unless (gethash id (declared-ids decls))
      (let ((decl (make-uffi-declaration decls (gethash id (c-ids decls)))))
	(when decl
	  (print decl stream)
	  (set-type-status id decls +type-finalized+)))))
  (terpri stream))

(defun write-uffi-declarations-to-file (decls path &key package)
  (with-open-file (defout path :direction :output :if-exists :supersede)
    (when package
      (print `(in-package ,(intern (string-upcase (package-name package)) :keyword)) defout)
      (terpri defout))
    (write-uffi-declarations decls defout)))

