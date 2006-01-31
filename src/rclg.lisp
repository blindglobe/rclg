;;; Bunch of old crap lives here.

(defpackage "RCLG"
  (:use :common-lisp :uffi :rclg-load )
	;; :common-idioms)
  (:export :start-r :rclg :r :sexp :*backconvert* :*r-started*
	   :r-convert :r-do-not-convert :convert-to-r
	   :sexp-not-needed :update-r :def-r-call :*r-NA* :r-na))

(in-package :rclg)

(defun safe-unprotect (poss-sexp)
  (when (and (typep poss-sexp 'sexp-holder)
	     (slot-value poss-sexp 'protected))
    (%rf-unprotect-ptr (slot-value poss-sexp 'sexp))
    (setf (slot-value poss-sexp 'protected) nil))
  poss-sexp)


(defmacro r-convert (&body body)
  (let ((*backconvert* t)) ;; Compile time
    `(let ((*backconvert* t)) ;; Run time
      ,@body)))

(defmacro r-do-not-convert (&body body)
  (let ((*backconvert* nil))   ;; Compile time
    `(let ((*backconvert* nil))  ;; Run time
      ,@body)))



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








  





;;; Primarily for updating graphics


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
#+sbcl
(eval-when (:load-toplevel)
  (sb-int:set-floating-point-modes :traps (list :overflow)))

;; (eval-when (:load-toplevel)
;;   (let ((current-traps (cadr (member :traps (sb-int:get-floating-point-modes)))))
;;     (when (find :invalid current-traps)
;;       (progn
;; 	(warn "WARNING: removing :invalid from floating-point-modes traps.")
;; 	(sb-int:set-floating-point-modes :traps 
;; 					 (remove :invalid current-traps))))))


(eval-when (:load-toplevel)
  (start-r))

#+cmu
(eval-when (:load-toplevel)
  (mp:make-process (lambda () (do () (nil) (progn (update-r) (sleep 0.1))))))
