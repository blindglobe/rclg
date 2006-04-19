
;; What is this talk of 'release'? Klingons do not make software
;; 'releases'.  Our software 'escapes' leaving a bloody trail of
;; designers and quality assurance people in it's wake.

;;;#1 Introduction

;; This contains code for development, checking, loading, etc.
;; Basically, a scratch location, including example demos and test
;; cases for using.

;; if needed...?  Shouldn't be, since rclg.asd ought to take care of
;; most of the issues that we have.
;(asdf:operate 'asdf:compile-op 'cffi)
(asdf:operate 'asdf:load-op 'cffi)
(asdf:operate 'asdf:compile-op 'rclg)
(asdf:operate 'asdf:load-op 'rclg)

;; We use the rclg-user package for work.  reasonable approach at this point. 

(in-package :rclg-user)

;; (symbol-package 'start-r)
;; *package*
;; rclg-init::*r-started*
(start-rclg)
;; rclg-init::*r-started*

(r "Cstack_info")


;; library problems are causing things to fail here.  By library
;; problems, I mean that there is a problem between GCC 4.0 and GCC
;; 4.1 systems.  While I don't know for sure if this is the main
;; problem, I am sure that it is part of the problem.


(r "print.default" 3) ;; works
(r 'rnorm 10) ; barf
(r "RNORM" 10) ; fail
(r "rnorm" 10) ; should work; hasn't on my system due to Debian issues.

;(r "a <- 1") ;; should not work -- what is the right way to assign
	     ;; variables in R?  We could use the function call,
	     ;; i.e. something like (r "assign" "y" 10), but that
	     ;; doesn't quite seem right.

(rnb "rnorm") ;; call without blocking or protecting anything.

(rclg-control::rname-to-robj "rnorm")
;NIL if we have library problems
(rclg-control::rname-to-robj "print")
;#.(SB-SYS:INT-SAP #X082F3FF8)
(rclg-control::rname-to-robj "c")
;#.(SB-SYS:INT-SAP #X08191A44)
(rclg-control::rname-to-robj "print.default")
;#.(SB-SYS:INT-SAP #X082FAA04)
(rclg-control::rname-to-robj "+")
;#.(SB-SYS:INT-SAP #X0818FD78)
(rclg-control::rname-to-robj "[")
;#.(SB-SYS:INT-SAP #X08190360)

;; Note that the first checks if we've got an object, and the second
;; checks to see if we have a function.  R doesn't think they are the
;; same (not unlike CL).
(rclg-control::rname-to-robj "runif")
(rclg-control::rname-to-rfun "runif")
(rclg-control::rname-to-rfun "search")


;; These worked
(r "Sys.getenv" "LD_LIBRARY_PATH")
(r "Sys.getenv" "LD_PRELOAD")

(r "search") ;; works

;; These don't work if we have library problems.
(r "library" "stats") 
(r "library" "MASS")
(r "library" "Biobase") 


;;; taken from cls-r.lisp code:

#-nil
(progn
  (defctype R-SEXP :pointer
    :documentation "R SEXP type.  Need to clarify definition.")

  (defcfun "R_tryEval"  :int
    (Rexpr R-SEXP)
    (Renv R-SEXP)
    (Rerror :pointer)) ; an integer pointer returning the error, it probably needs to be pre-alloc'd
  
  (defcfun "R_ParseVector" R-SEXP
    (textbuffer :string) (n :int) (status :pointer))
  
  (defvar RtestInPlot
    (foreign-alloc
     :string
     :initial-contents '("{plot(1:10, pch=\"+\");print(1:10)}")
     :null-terminated-p t))
  
  (defvar RtestInSum
    (foreign-alloc
     :string
     :initial-contents '("{sum(1:10);print(1:10)}")
     :null-terminated-p t))
  
  (defvar RstatusPtr (foreign-alloc :char))
  
  ;; evaluation: compute and print
  (princ (R-ParseVector RtestInSum 1 RstatusPtr))
  
  (defvar Rstatus1 (foreign-alloc :int 
				  :initial-element 1))
  (princ (R-tryEval RtestInSum Rstatus1 RstatusPtr))
  
  (princ "Did we get here?")
  
  ;; evaluation: plots
  (princ (R-ParseVector RtestInPlot 1 RstatusPtr))
  
  (defvar Rstatus1 (foreign-alloc :int 
				  :initial-element 1))
  (princ (R-tryEval RtestInPlot Rstatus1 RstatusPtr))
  
  (princ "Did we get here?"))


(r "lm" 3)  ;; fails and should
;; (r "lm" :model "Y~X" :data ptrToDataFrame)


(rclg-control::r-call "rnorm")

;;(rclg-foriegns:R_tryEval

(use-package :cffi)
(defvar Rtest-rnorm
    (foreign-alloc
     :string
     :initial-contents '("rnorm")
     :null-terminated-p t))

(r-bound Rtest-rnorm)

(r 'Rtest-rnorm)

(r "rnorm")

(rclg-control::rname-to-robj "library")

;;; Local variables:
;;; mode: outline-minor
;;; outline-header-prefix: ";;;"
;;; End:
