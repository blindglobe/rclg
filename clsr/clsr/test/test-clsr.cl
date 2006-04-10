
(in-package :clsr-test)

(defun test-clsr-random-num ()
  (r::|GetRNGstate|)
  (cons (r::|norm_rand|)
        (r::|norm_rand|)))

(defun test-clsr-2 (cmd)
  (clsr::r-sexp-to-lisp-sexp (clsr::eval-r-command cmd)))

(defun test-clsr/nilsxp ()
  (clsr::with-r-call (answer "NULL")
    (print (clsr::r-sexp-to-lisp-sexp answer))
    (assert (equalp nil (clsr::r-sexp-to-lisp-sexp answer)))))

(defun test-clsr/strsxp ()
  (clsr::with-r-call (answer "c(\"these\", \"are\", \"strings\")")
    (let ((lsxp (clsr::r-sxp-ref answer)))
      (print (clsr::r-sexp-to-lisp-sexp (clsr::sxp lsxp)))
      (print (clsr::sxp-ref-element lsxp 0))
      (assert (equalp #("these" "are" "strings")
                      (clsr::r-sexp-to-lisp-sexp answer))))))

(defun test-clsr/intsxp ()
  (clsr::with-r-call (answer "c(1,2,3)")
    (print (clsr::r-sexp-to-lisp-sexp answer))
    (assert (equalp #(1 2 3)
                    (clsr::r-sexp-to-lisp-sexp answer)))))

(defun test-clsr/realsxp ()
  (clsr::with-r-call (answer "c(1.0,2.0,3.0)")
    (print (clsr::r-sexp-to-lisp-sexp answer))
    (assert (equalp #(1.0d0 2.0d0 3.0d0)
                    (clsr::r-sexp-to-lisp-sexp answer)))))

(defun test-clsr/cplxsxp ()
  (clsr::with-r-call (answer "c(1.0+2.0i, 3.0+4.0i)")
    (print (clsr::r-sexp-to-lisp-sexp answer))
    (assert (equalp #(#c(1.0d0 2.0d0) #c(3.0d0 4.0d0))
                    (clsr::r-sexp-to-lisp-sexp answer)))))

(defun test-clsr/vecsxp ()
  (clsr::with-r-call (answer "c(\"bogus\", 12, 1.0+2.0i, 3.0+4.0i)")
    (print (clsr::r-sexp-to-lisp-sexp answer))
    (assert (equalp #("bogus" "12" "1+2i" "3+4i")
                    (clsr::r-sexp-to-lisp-sexp answer)))))

(defun test-clsr/lglsxp ()
  (clsr::with-r-call (answer "as.logical(c(1,0,1))")
    (print (clsr::r-sexp-to-lisp-sexp answer))
    (assert (equalp #*101
                    (clsr::r-sexp-to-lisp-sexp answer)))))

(defun test-clsr/data.frame ()
  (clsr::with-r-call (answer
                      "data.frame(moose=c(\"bar\",\"baz\",\"donkey\", \"baz\",\"quz\"), frob=c(1,2,5,7,pi))")
    (clsr::r-sexp-to-lisp-sexp answer)))

(defun test-clsr/matrix ()
  (clsr::with-r-call (answer "matrix(3,nrow=64,ncol=32)")
    answer))

(defmacro vector-bind (symbols vector &body body)
  (ch-util::with-unique-names (l)
    `(multiple-value-bind (,@symbols)
         (values-list (loop for ,l across ,vector collect ,l))
       (progn
         ,@body))))

(defun run-tests ()
  (test-clsr/nilsxp)
  (test-clsr/strsxp)
  (test-clsr/intsxp)
  (test-clsr/realsxp)
  (test-clsr/cplxsxp)
  (test-clsr/vecsxp)
  (test-clsr/lglsxp))

(defparameter *r-clem-matrix-hash* (make-hash-table :test 'equal))
(dolist
    (x `((,r::|LGLSXP| . clem::bit-matrix)
         (,r::|INTSXP| . clem::integer-matrix)
         (,r::|REALSXP| . clem::double-float-matrix)
         (,r::|CPLXSXP| . clem::complex-matrix)))
  (setf (gethash (car x) *r-clem-matrix-hash*) (cdr x)))

(defun r-matrix-to-clem-matrix (matsxp)
  (let ((dim (clsr::matrix-dim matsxp)))
    (let ((rows (aref dim 0))
          (cols (aref dim 1)))
      (let ((matrix-type (gethash (r::|TYPEOF| matsxp) *r-clem-matrix-hash*)))
        (let ((mat (make-instance matrix-type :rows rows :cols cols)))
          (dotimes (i rows)
            (declare (type fixnum i))            
            (dotimes (j cols)
              (declare (type fixnum j))
              (setf (clem::mref mat i j)
                    (clsr::rref matsxp i j))))
          mat)))))

(defun r-matrix-to-clem-matrix-2 (sxp)
  (let ((dim (clsr::dim sxp)))
    (vector-bind (rows cols)
        dim
      (cond ((equal (r::|TYPEOF| sxp) r::|REALSXP|)
             (let ((cmat (make-instance 'clem:real-matrix :rows rows :cols cols)))
               (dotimes (i rows)
                 (dotimes (j cols)
                   (setf (clem::mref cmat i j) (clsr::r-vector-sexp-element sxp (+ (* i cols) j)))
                   ))
               cmat))))))

(declaim (inline (setf clem::double-float-matrix-mref)))

(defun r-real-matrix-to-clem-double-float-matrix (matsxp)
  (let ((dim (clsr::matrix-dim matsxp))
        (matrix-type (gethash (r::|TYPEOF| matsxp) *r-clem-matrix-hash*)))
    (let ((rows (aref dim 0))
          (cols (aref dim 1)))
      (declare (optimize (speed 3) (space 0))
               (type fixnum rows cols))
          (let ((mat (make-instance matrix-type :rows rows :cols cols)))
            (dotimes (i rows)
              (declare (type fixnum i))
              (dotimes (j cols)
                (declare (type fixnum j))
                (setf (clem::double-float-matrix-mref mat i j)
                      (clsr::real-rref matsxp i j :cols cols))))
            mat))))

(defun clem-matrix-to-r-matrix (mat matsxp)
  (let ((dim (clsr::matrix-dim matsxp)))
    (let ((rows (aref dim 0))
          (cols (aref dim 1)))
          (dotimes (i rows)
            (declare (type fixnum i))
            (dotimes (j cols)
              (declare (type fixnum j))
              (setf (clsr::rref matsxp i j)
                    (clem::mref mat i j))))))
  matsxp)

(defun test-r-matrix ()
  (clsr::with-parsed-r-expression (expn-sxp "matrix(5,1024,1024)")
    (clsr::with-evaled-r-expression (answer-sxp expn-sxp)
      (time (clsr-test::r-real-matrix-to-clem-double-float-matrix answer-sxp)))))

(defun build-env ()
  (clsr::with-parsed-r-expression (expn-sxp
                                   "e1 <- new.env();
assign(\"s1\",\"v1\",envir=e1);
assign(\"s2\",\"v2\",envir=e1);
assign(\"s3\",\"v3\",envir=e1);
")
    (clsr::with-evaled-r-expression (answer-sxp expn-sxp))))

(defun test-clsr/get ()
  (clsr::with-parsed-r-expression (expn-sxp "get(\"s1\", envir=e1)")
    (clsr::with-evaled-r-expression (answer-sxp expn-sxp)
      answer-sxp)))
    
(defun test-clsr/ls ()
  (clsr::with-parsed-r-expression (expn-sxp "ls(e1)")
    (clsr::with-evaled-r-expression (answer-sxp expn-sxp)
      answer-sxp)))
    
(defun test-clsr/ls-env (robj)
  (clsr::with-parsed-r-expression (expn-sxp (format nil "ls(~A)" robj))
    (clsr::with-evaled-r-expression (answer-sxp expn-sxp)
      answer-sxp)))
    
(defun test-clsr/get-env (robj envir)
  (clsr::with-parsed-r-expression (expn-sxp (format nil "get(~S,envir=~A)" robj envir))
    (clsr::with-evaled-r-expression (answer-sxp expn-sxp)
      answer-sxp)))
    
(defun test-clsr/init-bioc ()
  (clsr::with-parsed-r-expression (expn-sxp "library(\"drosophila2\")")
    (clsr::with-evaled-r-expression (answer-sxp expn-sxp)
      answer-sxp)))

(defun test-clsr/test-bioc-1 ()
  (clsr::with-parsed-r-expression (expn-sxp (format nil "ls(drosophila2SYMBOL)[1:10]"))
    (clsr::with-evaled-r-expression (answer-sxp expn-sxp)
      (let ((probes (clsr::r-sexp-to-lisp-sexp answer-sxp)))
        (loop for p across probes
           collect (aref (clsr::r-sexp-to-lisp-sexp
                          (clsr::with-parsed-r-expression
                              (expn-sxp (format nil "get(~S,envir=~A)" p "drosophila2SYMBOL"))
                            (clsr::with-evaled-r-expression (answer-sxp expn-sxp)
                              answer-sxp))) 0))))))

(defun vector-to-lisp (v)
  (loop for e across v collect e))

(defun flatten-vector-of-vectors (vv)
    (loop for v1 across vv
       append (loop for v2 across v1
                    collect v2)))

(defun test-clsr/test-bioc-2 ()
  (clsr::with-parsed-r-expression
      (expn-sxp "mget (ls(drosophila2SYMBOL)[1:10], envir=drosophila2SYMBOL)")
    (clsr::with-evaled-r-expression (answer-sxp expn-sxp)
      (flatten-vector-of-vectors (clsr::r-sexp-to-lisp-sexp answer-sxp)))))

(defun test-clsr/test-bioc-3 (env)
  (clsr::with-parsed-r-expression
      (expn-sxp (format nil "mget (ls(~A)[1:10], envir=~S)" env env))
    (clsr::with-evaled-r-expression (answer-sxp expn-sxp)
      (flatten-vector-of-vectors (clsr::r-sexp-to-lisp-sexp answer-sxp)))))

(sb-alien::define-alien-callback r-callback-test
    r::|SEXP|
  ((arg1 (* (sb-alien:struct r::|SEXPREC|)))
   (arg2 (* (sb-alien:struct r::|SEXPREC|))))
  (let ((ans (r::|Rf_allocVector| r::|REALSXP| 1)))
    (setf (sb-alien:deref (R::|REAL| ans) 0)
          (* (clsr::realsxp-element arg1 0)
             (clsr::realsxp-element arg2 0)))
    ans))

(defun test-clsr/test-callback ()
  (declare (optimize (debug 2)))
  (let ((extp (clsr::r-make-ext-ptr-sxp-from-callback r-callback-test)))
    (clsr::with-parsed-r-expression (parsed ".Call(\"placeholder\",3.5,22)")
      (let ((langsxp (r::|VECTOR_ELT| parsed 0)))
        (r::|SETCAR| (r::|CDR| langsxp) extp)
        (clsr::with-evaled-r-expression (answer parsed)
          (print (cons 'answer (clsr::r-sexp-to-lisp-sexp answer))))))))

(sb-alien::define-alien-callback r-callback-test-1
    r::|SEXP|
  ((arg1 (* (sb-alien:struct r::|SEXPREC|)))
   (arg2 (* (sb-alien:struct r::|SEXPREC|))))
  (let* ((n (r::|LENGTH| arg1))
         (ans (r::|Rf_allocVector| r::|REALSXP| n)))
    (loop for i below n
       do (setf (sb-alien:deref (R::|REAL| ans) i)
                (* (clsr::realsxp-element arg1 i)
                   (clsr::realsxp-element arg2 i))))
    ans))

(defun listsxp-element-list (sxp)
  (cond ((equal (r::|TYPEOF| (r::|CAR| sxp)) r::|NILSXP|)
	 nil)
	(t (cons (r::|CAR| sxp) (listsxp-element-list (r::|CDR| sxp))))))

(sb-alien::define-alien-callback r-callback-test-2
    r::|SEXP|
  ((arg r::|SEXP|))
  (let* ((args (listsxp-element-list (r::|CDR| arg)))
	 (k (length args)))
    (if (plusp k)
	(let* ((n (r::|Rf_length| (car args))))
	  (if (plusp n)
	      (let ((ans (r::|Rf_allocVector| r::|REALSXP| n)))
		;; should really do argument recycling, or at least
		;; some checking here, but this is a toy example...
		(loop for i below n
		   do (setf (sb-alien:deref (R::|REAL| ans) i)
			    (apply #'* (loop for j in args
					  collect (clsr::realsxp-element j i)))))
		ans)
	      r::|R_NilValue|))
	r::|R_NilValue|)))
    
(defun test-clsr/test-callback-mult (&rest lists)
  (declare (optimize (debug 2)))
  (let ((extp (clsr::r-make-ext-ptr-sxp-from-callback r-callback-test-2)))
    (clsr::with-parsed-r-expression (parsed
				     (format nil ".External(\"placeholder\",~{c(~{~f~^,~})~^,~})" lists))
      (let ((langsxp (r::|VECTOR_ELT| parsed 0)))
        (r::|SETCAR| (r::|CDR| langsxp) extp)
        (clsr::with-evaled-r-expression (answer parsed)
          (print (cons 'answer (clsr::r-sexp-to-lisp-sexp answer))))))))

(defun format-sxp-ref-elements (ref &key stream)
  (format stream
          "~{~A~^ ~}"
          (loop for i below (clsr::sxp-ref-length ref)
             collect (clsr::sxp-ref-element ref i))))

(defmacro with-preserved-sxp-ref ((ref) &body body)
  `(progn
     (clsr::preserve-sxp ,ref)
     ,@body
     (clsr::release-sxp ,ref)))

(defun test-sxp-ref (expn)
  (clsr::with-r-call (answer expn)
    (let ((ref (clsr::r-sxp-ref answer)))
      (with-preserved-sxp-ref (ref)
        (print (format-sxp-ref-elements ref))))))

(defun test-lgl-sxp-ref ()
  (test-sxp-ref "as.logical(c(1,0,1))"))

(defun test-int-sxp-ref ()
  (test-sxp-ref "as.integer(c(1,2,3))"))

(defun test-real-sxp-ref ()
  (test-sxp-ref "c(1.1,2.2,3.3)"))

(defun test-str-sxp-ref ()
  (test-sxp-ref "c(\"these\", \"are\", \"strings\")"))

(defun test-str-sxp-ref-2 ()
  (clsr::with-r-call (answer "c(\"these\", \"are\", \"strings\")")
    (let ((ref (clsr::r-sxp-ref answer)))
      (with-preserved-sxp-ref (ref)
        (print (format-sxp-ref-elements ref))
        (setf (clsr::sxp-ref-element ref 1) "were")
        (print (format-sxp-ref-elements ref))))))

(defun test-cplx-sxp-ref ()
  (test-sxp-ref "c(1.0+2.0i, 3.0+4.0i)"))

(defun test-gc-torture ()
  (clsr::with-r-call (answer "gctorture(TRUE)")
    (print (clsr::r-sexp-to-lisp-sexp answer))))

(defun init-gdd ()
  (clsr::with-r-call (answer "library(GDD)")))

(defparameter *moose* 42)

(defun lisp-lookup (symbol &key package)
  (symbol-value (apply #'find-symbol
                       (cons symbol
                             (when package (list (find-package package)))))))

(defun test-gdd ()
  (clsr::with-r-call (answer "GDD(\"demo.png\", width=400, height=400)"))
  (clsr::with-r-call (answer "plot(rnorm(200), rnorm(200), col=2)"))
  (clsr::with-r-call (answer "dev.off()")))


(sb-alien::define-alien-callback get-lisp-symbol-integer-value
    r::|SEXP|
  ((arg r::|SEXP|))
  (let* ((args (listsxp-element-list (r::|CDR| arg))))
    (let ((symbol (clsr::charsxp-to-string (r::|VECTOR_ELT| (car args) 0)))
          (package (find-package 'clsr-test)))
      (let ((ret-sxp (r::|Rf_allocVector| r::|INTSXP| 1)))
        (setf (sb-alien:deref (r::|INTEGER| ret-sxp) 0) 
              (symbol-value (apply #'find-symbol
                                   (cons (string-upcase symbol)
                                         (when package (list (find-package package)))))))
        ret-sxp))))

(sb-alien::define-alien-callback add-two-ints
    r::|SEXP|
  ((arg r::|SEXP|))
  (let* ((args (listsxp-element-list (r::|CDR| arg))))
    (let ((sym1 (clsr::charsxp-to-string (r::|VECTOR_ELT| (car args) 0)))
          (sym2 (clsr::charsxp-to-string (r::|VECTOR_ELT| (cadr args) 0)))
          (package (find-package 'clsr-test)))
      (let ((ret-sxp (r::|Rf_allocVector| r::|INTSXP| 1)))
        (setf (sb-alien:deref (r::|INTEGER| ret-sxp) 0) 
              (+ (symbol-value (apply #'find-symbol
                                      (cons (string-upcase sym1)
                                            (when package (list (find-package package))))))
                 (symbol-value (apply #'find-symbol
                                      (cons (string-upcase sym2)
                                            (when package (list (find-package package))))))))
        ret-sxp))))
    
(defun test-clsr/test-get-lisp-symbol-integer-value (sym)
  (declare (optimize (debug 2)))
  (let ((extp (clsr::r-make-ext-ptr-sxp-from-callback get-lisp-symbol-integer-value)))
    (clsr::with-parsed-r-expression (parsed
				     (format nil ".External(\"placeholder\",~S)" sym))
      (let ((langsxp (r::|VECTOR_ELT| parsed 0)))
        (r::|SETCAR| (r::|CDR| langsxp) extp)
        (clsr::with-evaled-r-expression (answer parsed)
          (print (clsr::r-sexp-to-lisp-sexp answer)))))))

(defmacro r-define-lisp-function (function-spec (&rest args))
  "takes a lisp callback and makes an R function from it. If
  function-spec is a list, the first item specifies the r-function
  name and the second the lisp-callback. If function-spec is an atom,
  function-spec if both the r-function name and the lisp-callback."
  (destructuring-bind (r-function lisp-function)
      (cond ((listp function-spec) function-spec)
            (t (list function-spec function-spec)))
    `(let ((extp (clsr::r-make-ext-ptr-sxp-from-callback ,lisp-function)))
       (clsr::with-parsed-r-expression
           (parsed (format nil
                           "~A <- function(~{~A~^,~}) { .External(\"placeholder\",~{~A~^,~}) }"
                           ,r-function (list ,@args) (list ,@args)))
         (let ((langsxp (r::|CDR| (r::|CADDR| (r::|CADDR| (r::|VECTOR_ELT| parsed 0))))))
           (r::|SETCAR| (r::|CDAR| langsxp) extp))
         (clsr::with-evaled-r-expression (answer parsed)
           (print (clsr::r-sexp-to-lisp-sexp answer)))))))

(r-define-lisp-function ("y" get-lisp-symbol-integer-value) ("arg1"))
(r-define-lisp-function ("w" add-two-ints) ("arg1" "arg2"))

(defun test-moose (sym)
  (clsr::with-r-call (answer (format nil "y(~S)" sym))
    (print (clsr::r-sexp-to-lisp-sexp answer))))

(defun test-add (n1 n2)
  (clsr::with-r-call (answer (format nil "w(~S, ~S)" n1 n2))
    (print (clsr::r-sexp-to-lisp-sexp answer))))



(defun make-lisp-integer-ref-lambda (lisp-int)
  (sb-alien::alien-lambda
      r::|SEXP|
    ((arg r::|SEXP|))
;    (let* ((args (listsxp-element-list (r::|CDR| arg))))
    (let ((ret-sxp (r::|Rf_allocVector| r::|INTSXP| 1)))
      (setf (sb-alien:deref (r::|INTEGER| ret-sxp) 0) 
            lisp-int)
      ret-sxp)))

(defun make-lisp-int-vector-ref-lambda (lisp-int-vector)
  (sb-alien::alien-lambda
      r::|SEXP|
    ((arg r::|SEXP|))
    (let ((i (sb-alien:deref (r::|INTEGER| arg) 0))
          (ret-sxp (r::|Rf_allocVector| r::|INTSXP| 1)))
      (setf (sb-alien:deref (r::|INTEGER| ret-sxp) 0) 
            (aref lisp-int-vector i))
      ret-sxp)))

