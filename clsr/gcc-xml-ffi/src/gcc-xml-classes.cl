
(in-package :gcc-xml-ffi)

(defgeneric do-tag (obj tag val))
(defgeneric print-object-slots (obj stream))
(defgeneric print-object-children (obj stream))

(defclass c-declaration ()
  ((depends :accessor depends :initargs depends :initform nil))
  (:documentation "parent class of c-declarations found in the gcc-xml
  xml files"))

;;; get the required types of a c-declaration. returns a list of
;;; strings with the is, e.g. ("_23", "_34") 
(defgeneric get-required-types (obj)
  (:documentation "returns a list of text strings with the ids of the
  required types for a c-declaration"))

;;; default to nil
(defmethod get-required-types ((obj c-declaration))
  nil)

(defmethod print-object ((obj c-declaration) stream)
  (write-string "#<" stream)
  (write (type-of obj) :stream stream :circle nil :level nil :length nil)
  (print-object-slots obj stream)
  (print-object-children obj stream)
  (write-char #\> stream))

(defmethod print-object-children ((obj c-declaration) stream))

;;; mixin for all slots with an id
(defclass id-mixin () ((id :accessor id :initargs :id)))

(defmethod print-object-slots ((obj id-mixin) stream)
  (when (next-method-p) (call-next-method))
  (when (slot-boundp obj 'id)
    (write-string " id=" stream)
    (write (id obj) :stream stream :circle nil :level nil :length nil)))

(defmethod do-tag ((obj id-mixin) tag val)
  (cond ((string-equal (string-downcase tag) "id") 
	 (setf (id obj) val))
	(t (when (next-method-p) (call-next-method)))))

(defclass name-mixin () ((name :accessor name :initargs :name)))

(defmethod print-object-slots ((obj name-mixin) stream)
  (when (next-method-p) (call-next-method))
  (when (and (slot-boundp obj 'name) (name obj))
    (write-string " name=" stream)
    (write (name obj) :stream stream :circle nil :level nil :length nil)))

(defmethod do-tag ((obj name-mixin) tag val)
  (cond ((string-equal (string-downcase tag) "name")
	 (setf (name obj) val))
	(t (when (next-method-p) (call-next-method)))))

(defclass type-mixin () ((type-id :accessor type-id :initargs :type-id)))

(defmethod print-object-slots ((obj type-mixin) stream)
  (when (next-method-p) (call-next-method))
  (when (slot-boundp obj 'type-id)
    (write-string " type=" stream)
    (write (type-id obj) :stream stream :circle nil :level nil :length nil)))

(defmethod do-tag ((obj type-mixin) tag val)
  (cond ((string-equal (string-downcase tag) "type")
	 (setf (type-id obj) val))
	(t (when (next-method-p) (call-next-method)))))

(defclass context-mixin () ((context :accessor context :initargs :context)))

(defmethod do-tag ((obj context-mixin) tag val)
  (cond ((string-equal (string-downcase tag) "context")
	 (setf (context obj) val))
	(t (when (next-method-p) (call-next-method)))))

(defclass mangled-mixin () ((mangled :accessor mangled :initargs :mangled)))

(defmethod do-tag ((obj mangled-mixin) tag val)
  (cond ((string-equal (string-downcase tag) "mangled")
	 (setf (mangled obj) val))
	(t (when (next-method-p) (call-next-method)))))

(defclass source-mixin ()
  ((location :accessor source-location :initargs :location)
   (file :accessor source-file :initargs :file)
   (line :accessor source-line :initargs :line)))

(defmethod do-tag ((obj source-mixin) tag val)
  (cond ((string-equal (string-downcase tag) "location") 
	 (setf (source-location obj) val))
	((string-equal (string-downcase tag) "file") 
	 (setf (source-file obj) val))
	((string-equal (string-downcase tag) "line") 
	 (setf (source-line obj) val))
	(t (when (next-method-p) (call-next-method)))))

(defclass function-mixin ()
  ((returns :accessor function-returns :initargs :returns)
   (arguments :accessor function-arguments :initargs :arguments :initform nil)))

(defmethod do-tag ((func function-mixin) tag val)
  (cond ((string-equal (string-downcase tag) "returns") 
	 (setf (function-returns func) val))
	(t (when (next-method-p) (call-next-method)))))

(defmethod print-object-children ((func function-mixin) stream)
  (when (and (slot-boundp func 'arguments)
	     (function-arguments func))
    (dolist (arg (function-arguments func))
      (write-char #\Space stream)
      (print-object arg stream)))
  (when (next-method-p) (call-next-method)))

(defclass alignment-mixin ()
  ((alignment :accessor alignment :initargs :alignment)))

(defmethod do-tag ((align alignment-mixin) tag val)
  (cond ((string-equal (string-downcase tag) "align") 
	 (setf (alignment align) (read-number-from-string val)))
	(t (when (next-method-p) (call-next-method)))))

(defclass c-namespace (c-declaration id-mixin name-mixin context-mixin mangled-mixin)
  ((members :accessor namespace-members :initargs :members)))

(defmethod do-tag ((ns c-namespace) tag val)
  (cond ((string-equal (string-downcase tag) "members") 
	 (setf (namespace-members ns) val))
	(t (when (next-method-p) (call-next-method)))))

(defun do-namespace (attrs elements)
  (declare (ignore elements))
  (let ((ns (make-instance 'c-namespace)))
    (loop for (tag val) in attrs
       do (do-tag ns tag val))
    ns))

(defclass c-argument (c-declaration name-mixin type-mixin) ())

(defun do-argument (attrs elements)
  (declare (ignore elements))
  (let ((arg (make-instance 'c-argument)))
    (loop for (tag val) in attrs do (do-tag arg tag val))
    arg))

(defclass c-function (c-declaration id-mixin name-mixin source-mixin context-mixin function-mixin)
  ((extern :accessor function-extern :initargs :extern)))

(defmethod get-required-types ((func c-function))
  (let ((used-types))
    (do* ((l (function-arguments func) (cdr l))
	  (arg (car l) (car l)))
	 ((null l))
      (pushnew (type-id arg) used-types))
    (pushnew (function-returns func) used-types)
    (reverse used-types)))

(defmethod do-tag ((func c-function) tag val)
  (cond ((string-equal (string-downcase tag) "extern") 
	 (setf (function-extern func) val))
	(t (when (next-method-p) (call-next-method)))))

(defun do-function (attrs elements)
  (let ((func (make-instance 'c-function)))
    (loop for (tag val) in attrs do (do-tag func tag val))
    (loop for e in elements
       do (cond ((listp e)
                 (destructuring-bind (tag attrs &rest elements)
                     e
                   (cond ((string-equal (string-downcase tag) "argument")
                          (push (do-argument attrs elements) (function-arguments func)))
                         ((string-equal (string-downcase tag) "elipsis")
                          (print "got an elipsis...")))))))
    (when (function-arguments func)
      (setf (function-arguments func) (nreverse (function-arguments func))))
    func))

(defclass c-function-type (c-declaration id-mixin function-mixin) ())

(defmethod get-required-types ((func c-function-type))
  (let ((used-types))
    (do* ((l (function-arguments func) (cdr l))
	  (arg (car l) (car l)))
	 ((null l))
      (pushnew (type-id arg) used-types))
    (pushnew (function-returns func) used-types)
    (reverse used-types)))

(defun do-function-type (attrs elements)
  (let ((func-type (make-instance 'c-function-type)))
    (loop for (tag val) in attrs do (do-tag func-type tag val))
    (loop for e in elements
       do (cond ((listp e)
		 (destructuring-bind (tag attrs &rest elements)
		     e
		   (cond ((string-equal (string-downcase tag) "argument")
			  (push (do-argument attrs elements) (function-arguments func-type)))
			 ((string-equal (string-downcase tag) "elipsis")
			  (print "got an elipsis...")))))))
    (when (function-arguments func-type)
      (setf (function-arguments func-type) (nreverse (function-arguments func-type))))
    func-type))

(defclass c-enum-value (c-declaration name-mixin)
  ((init :accessor enum-value-init :initargs :name)))

(defmethod print-object-slots ((obj c-enum-value) stream)
  (when (next-method-p) (call-next-method))
  (when (slot-boundp obj 'init)
    (write-string " init=" stream)
    (write (enum-value-init obj) :stream stream :circle nil :level nil :length nil)))

(defmethod do-tag ((enum-val c-enum-value) tag val)
  (cond ((string-equal (string-downcase tag) "init") 
	 (setf (enum-value-init enum-val) val))
	(t (when (next-method-p) (call-next-method)))))

(defun do-enum-value (attrs elements)
  (declare (ignore elements))
  (let ((enum-val (make-instance 'c-enum-value)))
    (loop for (tag val) in attrs do (do-tag enum-val tag val))
    enum-val))

(defclass c-enumeration (c-declaration name-mixin id-mixin source-mixin context-mixin)
  ((values :accessor enumeration-values :initargs :values :initform nil)))
   
(defmethod print-object-children ((enum c-enumeration) stream)
  (when (and (slot-boundp enum 'values)
	     (enumeration-values enum))
    (dolist (val (enumeration-values enum))
      (write-char #\Space stream)
      (print-object val stream)))
  (when (next-method-p) (call-next-method)))

(defun do-enumeration (attrs elements)
  (let ((enum (make-instance 'c-enumeration)))
    (loop for (tag val) in attrs do (do-tag enum tag val))
    (loop for e in elements
       do (cond ((listp e)
		 (destructuring-bind (tag attrs &rest elements)
		     e
		   (cond ((string-equal (string-downcase tag) "enumvalue")
			  (push (do-enum-value attrs elements) (enumeration-values enum))))))))
    enum))

(defclass c-typedef (c-declaration id-mixin name-mixin source-mixin context-mixin type-mixin) ())
   
(defmethod get-required-types ((tdef c-typedef))
  (list (type-id tdef)))

(defun do-typedef (attrs elements)
  (declare (ignore elements))
  (let ((tdef (make-instance 'c-typedef)))
    (loop for (tag val) in attrs do (do-tag tdef tag val))
    tdef))

(defclass c-fundamental-type (c-declaration id-mixin name-mixin) ())
   
(defun do-fundamental-type (attrs elements)
  (declare (ignore elements))
  (let ((tdef (make-instance 'c-fundamental-type)))
    (loop for (tag val) in attrs do (do-tag tdef tag val))
    tdef))

(defclass c-pointer-type (c-declaration id-mixin name-mixin type-mixin) ())

(defmethod get-required-types ((ptr-type c-pointer-type))
  (list (type-id ptr-type)))

(defun do-pointer-type (attrs elements)
  (declare (ignore elements))
  (let ((tdef (make-instance 'c-pointer-type)))
    (loop for (tag val) in attrs do (do-tag tdef tag val))
    tdef))

(defclass c-cv-qualified-type (c-declaration id-mixin name-mixin type-mixin)
  ((const :accessor cv-qualified-type-const :initargs :const)))

(defmethod get-required-types ((obj c-cv-qualified-type))
  (list (type-id obj)))

(defmethod print-object-slots ((obj c-cv-qualified-type) stream)
  (when (next-method-p) (call-next-method))
  (when (slot-boundp obj 'const)
    (write-string " const=" stream)
    (write (cv-qualified-type-const obj) :stream stream :circle nil :level nil :length nil)))

(defmethod do-tag ((tdef c-cv-qualified-type) tag val)
  (cond ((string-equal (string-downcase tag) "const") 
	 (setf (cv-qualified-type-const tdef) val))
	(t (when (next-method-p) (call-next-method)))))

(defun do-cv-qualified-type (attrs elements)
  (declare (ignore elements))
  (let ((tdef (make-instance 'c-cv-qualified-type)))
    (loop for (tag val) in attrs do (do-tag tdef tag val))
    tdef))


(defclass c-reference-type (c-declaration id-mixin name-mixin type-mixin) ())

(defmethod get-required-types ((obj c-reference-type))
  (list (type-id obj)))

(defun do-reference-type (attrs elements)
  (declare (ignore elements))
  (let ((tdef (make-instance 'c-reference-type)))
    (loop for (tag val) in attrs do (do-tag tdef tag val))
    tdef))


(defclass c-record (c-declaration
		    id-mixin name-mixin source-mixin
                    context-mixin mangled-mixin alignment-mixin)
  ((members :accessor members :initargs :values :initform nil)
   (bases :accessor bases :initargs :values :initform nil)))

(defun do-record (attrs elements record-type)
  (declare (ignore elements))
  (let ((record (make-instance record-type)))
    (loop for (tag val) in attrs do (do-tag record tag val))
    (unless (slot-boundp record 'name)
      (setf (name record) (mangled record)))
    record))

(defclass c-struct (c-record)
  ((incomplete :accessor struct-incomplete :initargs :incomplete)))

(defmethod get-required-types ((struc c-struct))
  (let ((required-types))
    (dolist (member-id (members struc))
      (pushnew member-id required-types))
    (reverse required-types)))

(defmethod do-tag ((struct c-struct) tag val)
  (cond  ((string-equal (string-downcase tag) "members") 
	  (setf (members struct)
		(split-id-list-string val)))
	 ((string-equal (string-downcase tag) "bases") 
	  (setf (bases struct) val))
	 (t (when (next-method-p) (call-next-method)))))

(defun do-struct (attrs elements)
  (do-record attrs elements 'c-struct))

(defclass c-union (c-record) ())

(defmethod get-required-types ((union c-union))
  (let ((required-types))
    (dolist (member-id (members union))
      (pushnew member-id required-types))
    (reverse required-types)))

(defmethod do-tag ((union c-union) tag val)
  (cond  ((string-equal (string-downcase tag) "members") 
	  (setf (members union)
		(split-id-list-string val)))
	 ((string-equal (string-downcase tag) "bases") 
	  (setf (bases union) val))
	 (t (when (next-method-p) (call-next-method)))))

(defun do-union (attrs elements)
  (declare (ignore elements))
  (let ((union (make-instance 'c-union)))
    (loop for (tag val) in attrs do (do-tag union tag val))
    (unless (slot-boundp union 'name)
      (setf (name union) (mangled union)))
    union))

(defclass c-field (c-declaration id-mixin name-mixin
				 source-mixin context-mixin
				 mangled-mixin type-mixin)
  ((offset :accessor offset :initargs :offset)))

(defmethod get-required-types ((field c-field))
  (list (type-id field)))

(defmethod do-tag ((field c-field) tag val)
  (cond ((string-equal (string-downcase tag) "offset") 
	 (setf (offset field) (read-number-from-string val)))
	(t (when (next-method-p) (call-next-method)))))

(defun do-field (attrs elements)
  (declare (ignore elements))
  (let ((field (make-instance 'c-field)))
    (loop for (tag val) in attrs do (do-tag field tag val))
    field))

(defclass c-array-type (c-declaration id-mixin type-mixin)
  ((min :accessor array-type-min :initargs :min)
   (max :accessor array-type-max :initargs :max)))

(defmethod get-required-types ((array-type c-array-type))
  (list (type-id array-type)))

(defmethod do-tag ((array-type c-array-type) tag val)
  (cond ((string-equal (string-downcase tag) "min") 
	 (setf (array-type-min array-type) val))
	((string-equal (string-downcase tag) "max") 
	 (setf (array-type-max array-type) val))
	(t (when (next-method-p) (call-next-method)))))

(defun do-array-type (attrs elements)
  (declare (ignore elements))
  (let ((array-type (make-instance 'c-array-type)))
    (loop for (tag val) in attrs do (do-tag array-type tag val))
    array-type))

(defclass c-constructor (c-declaration id-mixin name-mixin
				       source-mixin context-mixin
				       mangled-mixin type-mixin) ())

(defun do-constructor (attrs elements)
  (declare (ignore elements))
  (let ((constructor (make-instance 'c-constructor)))
    (loop for (tag val) in attrs do (do-tag constructor tag val))
    constructor))

(defclass c-class (c-declaration id-mixin name-mixin
				       source-mixin context-mixin
				       mangled-mixin) ())

(defun do-class (attrs elements)
  (declare (ignore elements))
  (let ((class (make-instance 'c-class)))
    (loop for (tag val) in attrs do (do-tag class tag val))
    class))

(defclass c-variable (c-declaration
		      id-mixin name-mixin
		      type-mixin context-mixin
		      source-mixin) ())

(defun do-variable (attrs elements)
  (declare (ignore elements))
  (let ((variable (make-instance 'c-variable)))
    (loop for (tag val) in attrs do (do-tag variable tag val))
    variable))

(defmethod get-required-types ((var c-variable))
  (list (type-id var)))

(defclass c-declaration-set ()
  ((ids :accessor c-ids :initarg :ids
	:initform (make-hash-table :test #'equal))
   (declared-ids :accessor declared-ids :initarg :declared-ids
		 :initform (make-hash-table :test #'equal))
   (namespaces :accessor c-namespaces :initarg :namespaces
	       :initform (make-hash-table :test #'equal))
   (enumerations :accessor c-enumerations :initarg :enumerations
		 :initform (make-hash-table :test #'equal))
   (functions :accessor c-functions :initarg :functions
	      :initform (make-hash-table :test #'equal))
   (function-types :accessor c-function-types :initarg :function-types
	      :initform (make-hash-table :test #'equal))
   (typedefs :accessor c-typedefs :initarg :typedefs
	     :initform (make-hash-table :test #'equal))
   (fundamental-types :accessor c-fundamental-types :initarg :fundamental-types
	     :initform (make-hash-table :test #'equal))
   (pointer-types :accessor c-pointer-types :initarg :pointer-types
		  :initform (make-hash-table :test #'equal))
   (cv-qualified-types :accessor c-cv-qualified-types :initarg :cv-qualified-types
		       :initform (make-hash-table :test #'equal))
   (reference-types :accessor c-reference-types :initarg :reference-types
		       :initform (make-hash-table :test #'equal))
   (structs :accessor c-structs :initarg :structs
	    :initform (make-hash-table :test #'equal))
   (unions :accessor c-unions :initarg :unions
	    :initform (make-hash-table :test #'equal))
   (fields :accessor c-fields :initarg :fields
	   :initform (make-hash-table :test #'equal))
   (array-types :accessor c-array-types :initarg :array-types
	   :initform (make-hash-table :test #'equal))
   (constructors :accessor c-constructors :initarg :constructors
		 :initform (make-hash-table :test #'equal))
   (classes :accessor c-classes :initarg :classes
		 :initform (make-hash-table :test #'equal))
   (variables :accessor c-variables :initarg :classes
	      :initform (make-hash-table :test #'equal))
   ))
