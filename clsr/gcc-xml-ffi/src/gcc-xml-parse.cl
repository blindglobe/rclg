
(in-package :gcc-xml-ffi)

(defun parse-gcc-xml-file (f)
  (with-open-file (xmlin f)
    (let ((xml (xmls::parse xmlin)))
      (destructuring-bind (tag attrs &rest elements)
	  xml
	(declare (ignore attrs))
	(when (string-equal (string-downcase tag) "gcc_xml")
	  (let ((decls (make-instance 'c-declaration-set)))
	    (dolist (e elements) (do-gcc-xml e decls))
	    decls))))))

(defun do-gcc-xml (sexp decls)
  (cond ((listp sexp)
	 (destructuring-bind (tag attrs &rest elements)
	     sexp
	   (let* ((key (intern (string-upcase tag) :keyword))
		  (obj
		   (case key
		     (:namespace
		      (let ((ns (do-namespace attrs elements)))
			(setf (gethash (id ns) (c-namespaces decls)) ns)))
		     (:function
		      (let ((func (do-function attrs elements)))
			(setf (gethash (id func) (c-functions decls)) func)))
		     (:functiontype
		      (let ((functype (do-function-type attrs elements)))
			(setf (gethash (id functype) (c-function-types decls)) functype)))
		     (:enumeration
		      (let ((enum (do-enumeration attrs elements)))
			(setf (gethash (id enum) (c-enumerations decls)) enum)))
		     (:typedef
		      (let ((tdef (do-typedef attrs elements)))
			(setf (gethash (id tdef) (c-typedefs decls)) tdef)))
		     (:fundamentaltype
		      (let ((tdef (do-fundamental-type attrs elements)))
			(setf (gethash (id tdef) (c-fundamental-types decls)) tdef)))
		     (:pointertype
		      (let ((tdef (do-pointer-type attrs elements)))
			(setf (gethash (id tdef) (c-pointer-types decls)) tdef)))
		     (:cvqualifiedtype
		      (let ((tdef (do-cv-qualified-type attrs elements)))
			(setf (gethash (id tdef) (c-cv-qualified-types decls)) tdef)))
		     (:referencetype
		      (let ((tdef (do-reference-type attrs elements)))
			(setf (gethash (id tdef) (c-reference-types decls)) tdef)))
		     (:struct
		      (let ((struct (do-struct attrs elements)))
			(setf (gethash (id struct) (c-structs decls)) struct)))
		     (:union
		      (let ((union (do-union attrs elements)))
			(setf (gethash (id union) (c-unions decls)) union)))
		     (:field
		      (let ((field (do-field attrs elements)))
			(setf (gethash (id field) (c-fields decls)) field)))
		     (:arraytype
		      (let ((arraytype (do-array-type attrs elements)))
			(setf (gethash (id arraytype) (c-array-types decls)) arraytype)))
		     (:constructor
		      (let ((constructor (do-constructor attrs elements)))
			(setf (gethash (id constructor) (c-constructors decls)) constructor)))
		     (:class
		      (let ((class (do-class attrs elements)))
			(setf (gethash (id class) (c-classes decls)) class)))
		     (:variable
		      (let ((variable (do-variable attrs elements)))
			(setf (gethash (id variable) (c-variables decls)) variable)))
		     )))
	     (when (and obj (id obj))
	       (setf (gethash (id obj) (c-ids decls)) obj)))))))

