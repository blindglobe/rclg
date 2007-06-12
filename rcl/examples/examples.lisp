(in-package :rcl)

;; loding rcl will automatically load the library

;; some functions are available without calling r-init first:
;; (rf-beta 2d0 3d0)
;; (exp-rand)

;; calling (r-init) starts the interpreter 

;; r% = r-funcall & return R object
;; r  = r-funcall & return lisp object
;; in both cases the output and messages are redirected 

;; (r% "print" (r% "summary" '(3 21 12 31 9 17 25 29 5 14)))

;; (r "print" (r-variable "pressure"))

;; the following will write Rplots.ps to the current directory
;; the device has to be "closed"
;; (r "plot" (r-variable "pressure"))
;; (r "dev.off" (r "dev.cur"))

(defun plot-cl.net-example ()
  (flet ((list-symbols (&optional package &aux symbols)
	   (mapcar #'symbol-name (if package 
				     (do-symbols (s package symbols) (push s symbols))
				     (do-all-symbols (s symbols) (push s symbols)))))) 
    (let ((lengths-cl (mapcar #'length (list-symbols "CL")))
	  (lengths-all (mapcar #'length (list-symbols))))
      (with-device ("/tmp/symbol-length" :pdf)
	(r-funcall "hist" lengths-cl :breaks "scott"
		   :ylab "number" :xlab "symbol length" :main "symbols in COMMON-LISP")
	(r-funcall "hist" lengths-all :breaks "scott"
		   :ylab "number" :xlab "symbol length" :main "symbols in all packages"))
      (warn "an X server is required for the generation of PNGs")
      #+NIL
      (progn
	(with-device ("/tmp/symbol-length-cl" :png)
	  (r-funcall "hist" lengths-cl :breaks "scott"
		     :ylab "number" :xlab "symbol length" :main "symbols in COMMON-LISP"))
	(with-device ("/tmp/symbol-length-all" :png)
	  (r-funcall "hist" lengths-all :breaks "scott"
		     :ylab "number" :xlab "symbol length" :main "symbols in all packages"))))))


