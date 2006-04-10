
(in-package :gcc-xml-ffi)

(defparameter *skip-gcc-builtin-functions* t)

(defparameter *verbose* nil)

(defun ffi-symbol-case (str)
  str)

(defun split-id-list-string (str)
  (let ((tokens) (tok))
    (loop for c across str
       do (if (char= #\Space c)
	      (progn (push (coerce (nreverse tok) 'string) tokens)
		     (setf tok nil))
	      (push c tok)))
    (when tok
      (push (coerce (nreverse tok) 'string) tokens))
    (nreverse tokens)))

(defun hash-table-keys (hash)
  (let ((keys))
    (maphash #'(lambda (key val) (declare (ignore val))
		       (push key keys))
	     hash)
    keys))

(defun read-number-from-string (str &key (start 0) end)
  (unless end (setf end (1- (length str))))
  (if (eql (char str start) #\-)
      (multiple-value-bind (val pos)
	  (read-number-from-string str :start (1+ start) :end end)
	(values (- val) pos))
      (let ((acc 0))
	(loop for i from start to end
	   do (let ((dc (digit-char-p (char str i))))
		(if dc
		    (setf acc (+ dc (* 10 acc)))
		    (return-from read-number-from-string (values acc i)))))
	(values acc end))))

(defun id-lessp (string1 string2 &key (start1 0) end1 (start2 0) end2)
  (if (char= (char string1 start1) (char string2 start2) #\_)
      (multiple-value-bind (id1 id1-end)
	  (read-number-from-string string1 :start 1)
	(multiple-value-bind (id2 id2-end)
	    (read-number-from-string string2 :start 1)
	  (cond ((< id1 id2) t)
		((> id1 id2) nil)
		(t (string-lessp string1 string2 :start1 id1-end :start2 id2-end)))))
      (string-lessp string1 string2
		    :start1 start1 :start2 start2
		    :end1 end1 :end2 end2)))

(defun sorted-hash-table-ids (h)
  (sort (hash-table-keys h) #'id-lessp))

(defun hash-table-to-plist (h &aux l)
  (if (hash-table-p h)
      (progn (maphash
	      #'(lambda (key val)
		  (setf l (cons (hash-table-to-plist val)
				(cons key l)))) h)
	     (nreverse l))
      h))

(defparameter *numbered-args* (make-hash-table))

(defun get-nth-arg-label (i)
  (let ((a (gethash i *numbered-args*)))
    (if a
	a
	(multiple-value-bind (sym status)
	    (intern (concatenate 'string "ARG" (format nil "~A" i)))
	  (declare (ignore status))
	  (setf (gethash i *numbered-args*) sym)))))

(defun get-decl-from-id (id decls)
  (gethash id (c-ids decls)))

(defconstant +type-undeclared+ nil)
(defconstant +type-requested+ 1)
(defconstant +type-forward-declared+ 2)
(defconstant +type-declared+ 3)
(defconstant +type-finalized+ 4)

(defun get-type-status (type-id decls)
;;  (print (cons 'checking type-id))
  (gethash type-id (declared-ids decls)))

(defun set-type-status (type-id decls status)
;;  (print (cons 'setting-declared type-id))
  (setf (gethash type-id (declared-ids decls)) status))

(defun check-type-forward-declared (type-id decls)
  (let ((status (get-type-status type-id decls)))
    (and status (>= status +type-forward-declared+))))

(defun check-type-declared (type-id decls)
  (let ((status (get-type-status type-id decls)))
    (and status (>= status +type-declared+))))

