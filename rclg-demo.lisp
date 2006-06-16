;; What is this talk of 'release'? Klingons do not make software
;; 'releases'.  Our software 'escapes' leaving a bloody trail of
;; designers and quality assurance people in it's wake.

;;;#1 Load everything

;; if needed...?  Shouldn't be, since rclg.asd ought to take care of
;; most of the issues that we have.
(asdf:operate 'asdf:compile-op 'cffi)
(asdf:operate 'asdf:compile-op 'rclg)

(asdf:operate 'asdf:load-op 'cffi)
(asdf:operate 'asdf:load-op 'rclg)

;;;#2 Go to where the functions are 

(in-package :rclg-user)

;; (symbol-package 'start-r)
;; *package*
;; rclg-init::*r-started*

;;;#3 Start R within Lisp

(start-rclg)

;; rclg-init::*r-started*

(rclg-init::check-stack)

(r "Cstack_info")

;; library problems are causing things to fail here.  libR.so needs to
;; be in the LD_LIBRARY_PATH prior to initialization of the common
;; lisp application.

;;;#4 Demonstration of commands

(r "print.default" 3)
(r "rnorm" 10)

(r "Sys.getenv" "LD_LIBRARY_PATH")
(r "Sys.getenv" "LD_PRELOAD")

(r "ls")
(r "search") ;; works

;(r "a <- 1") ;; should not work -- what is the right way to assign
	     ;; variables in R?  We could use the function call,
	     ;; i.e. something like (r "assign" "y" 10), but that
	     ;; doesn't quite seem right.

;; These don't work if we have library problems.
(r "library" "stats") 
(r library "MASS")
(r "library" "Biobase") 

(setf my.lib "Biobase")
my.lib
(r library my.lib)

(r "ls")

(r assign "x" 5)
(r assign "x2" (list 1 2 3 5))

(r assign "x2" #(1 2 3 5 3 4 5))
(r assign "z" "y")

(r "get" "x")
(r get "x2")
(r "get" "z")
(r get "z")
(r "ls")


(r assign "my.x" (r rnorm 10)) ;; fails only because we don't have the
;; translation tools working.
(r assign "my.x" (rnb rnorm 10)) ;; works at this point.

(r get "my.x")

(r "plot" #(2 3 3 2 1) #(3 5 7 3 2)) ; works

(r plot (list 1 2 3 4 5) (list 1 2 3 4 5) :main "My title")
(r plot :x (list 1 2 3 4 5) :y (list 5 4 3 4 5) :main "My title")

(r plot :y (list 5 4 3 4 5)  :x (list 1 2 3 4 5) :main "My title")

(r plot (rnb rnorm 10) (rnb rnorm 10)
   :main "silly" :xlab "xlabel" :ylab "ylabel")

;;; Need to be able to run!
(r assign "my.df" (r read.table "testdata.csv"))
(r summary "my.df")

;;; How to handle connections?

;;; How to handle S4 objects?
;;; Hook into the conversion?

;;; how do we terminate the R session?
(r "q" "y")

(aref (r rnorm 10) 3)

;;;#5 Old useless code.

#+nil
(progn
  (rclg-control::rname-to-robj "rnorm")
  ;;NIL if we have library problems
  (rclg-control::rname-to-robj "print")
  ;;#.(SB-SYS:INT-SAP #X082F3FF8)
  (rclg-control::rname-to-robj "c")
  ;;#.(SB-SYS:INT-SAP #X08191A44)
  (rclg-control::rname-to-robj "print.default")
  ;;#.(SB-SYS:INT-SAP #X082FAA04)
  (rclg-control::rname-to-robj "+")
  ;;#.(SB-SYS:INT-SAP #X0818FD78)
  (rclg-control::rname-to-robj "[")
  ;;#.(SB-SYS:INT-SAP #X08190360)

  ;; Note that the first checks if we've got an object, and the second
  ;; checks to see if we have a function.  R doesn't think they are the
  ;; same (not unlike CL).
  (rclg-control::rname-to-robj "runif")
  (rclg-control::rname-to-rfun "runif")
  (rclg-control::rname-to-rfun "search"))

;;; Local variables:
;;; mode: outline-minor
;;; outline-header-prefix: ";;;"
;;; End:
