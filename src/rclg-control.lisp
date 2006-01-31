(defpackage :rclg-control
  (:use :common-lisp :cffi :rclg-types :rclg-foreigns :rclg-access
	:rclg-convert :rclg-util)
  (:export :r :rnb :update-r))

(in-package :rclg-control)

(defun rname-to-robj (name)
  "If R has a mapping for name (name is a string), returns the SEXP
that points to it, otherwise returns NIL."
  (with-foreign-string (ident-foreign name)
    (let ((foreign-value
	   (%rf-find-var (%rf-install ident-foreign) *r-global-env*)))
      (if (r-bound foreign-value)
	  foreign-value
	  nil))))

(defun sexp-length (args)
  (+ 1 (length args) (- (count-keywords args))))

(defun count-keywords (args)
  (count-if #'keywordp args))

(defun r-call (name args)
  "Does the actual call to R.  r-call converts args into R objects.
Returns an unprotected, unconverted R object."
  (let ((func (rname-to-robj name)))
    (if (not func)
	(error "Cannot find function ~A" name)      
	(let ((exp (%rf-protect 
		    (%rf-alloc-vector #.(sexp-elt-type :langsxp) (sexp-length args)))))
	  (r-setcar exp func)
	  (parse-args (r-cdr exp) args)
	  (prog1 (r-eval exp)
	    (%rf-unprotect 1))))))  ;; r-call


(defun r-eval (expr)
  "Evaluate an R expression."
  (with-foreign-object (e :int)
    (setf (mem-ref e :int) 0)
    (let ((res (%r-try-eval expr *r-global-env* e)))
      (if (not (= (mem-ref e :int) 0))
	  (error "Bad expr: ~A" (get-r-error))
	  res))))

(defun parse-args (exp args)
  (do ((arglist args (cdr arglist)))
      ((null arglist) nil)
    (let ((cur (car arglist)))
      (if (keywordp cur)
	  (progn
	    (parse-keyword exp cur (cadr arglist))
	    (setf arglist (cdr arglist)))
	(parse-regular-arg exp cur))
      (setf exp (r-cdr exp)))))

(defun parse-keyword (exp kwd arg)
  (r-setcar exp arg)
  (with-foreign-string (f (string-downcase (symbol-name kwd)))
    (%set-tag exp (%rf-install f))))

(defun parse-regular-arg (exp arg)
  (r-setcar exp (convert-to-r arg)))

(defmacro get-name (symbol-or-string)
  (if (stringp symbol-or-string)
      symbol-or-string
    (string-downcase (symbol-name symbol-or-string))))

(defun reshape-array (old-array dims)
  (let ((result (make-array (to-list dims) 
			    :element-type (array-element-type old-array))))
    (over-column-major-indices (result cmi rmi)
      (setf (row-major-aref result cmi) (aref old-array rmi)))
    result))

(eval-when (:compile-toplevel :load-toplevel)
  (defmacro r (name &rest args)
    "The primary interface to RCLG.  Backconverts the answer.  Name can
be a symbol or string."  
    (with-gensyms (evaled names dims result)
      `(let ((,evaled (r-call (get-name ,name) ',args)))
	(let ((,result (convert-from-r ,evaled))
	      (,names (r-names ,evaled))
	      (,dims (r-dims ,evaled)))
	  (values (if ,dims (reshape-array ,result ,dims) 
		      ,result)
		  ,names)))))
  )

(defmacro rnb (name &rest args)
  "Calls R, but returns the unevaled R object.  Doesn't protect it."
  `(r-call (get-name ,name) ',args))

(defun r-names (robj)  
  (let ((names (%rf-get-attrib robj *r-names-symbol*)))
    (unless (r-nil names)
      (convert-from-r names))))

(defun r-dims (robj)
  (let ((dims (%rf-get-attrib robj *r-dims-symbol*)))
    (unless (r-nil dims)
      (convert-from-r dims))))

(defun update-R ()
  (%r-run-handlers *r-input-handlers*
		   (%r-check-activity 10000 0)))

(defun get-r-error ()
  (r geterrmessage))
