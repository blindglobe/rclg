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


 
;; Basically, you now have three choices:
;; 
;; r   --- calls R, and converts the result back to CL as best as it can.  If it can't convert, returns an unprotected
;;         sexp (probably a bug, probably should be protected)
;; 
;; rnb --- R no backconvert.  Calls R, and returns a protected unconverted R sexp.  Useful when you want to
;;         manipulate something on the R side and give it a CL name
;; 
;; rnbi --- R no backconvert internal.  Calls R, returns a protected
;;          uncoverted R sexp.  However, it's tagged differently, and
;;          as soon as you use this as an argument to a function, it
;;          unprotects the sexp.  Useful for holding anonymous
;;          intermediate R results you don't want to backconvert.
;; 
;; Protection/unprotection controls whether R can GC the sexp.
;; 
;; Example: 
;; 
;; CL-USER> (defparameter *x* (r seq 1 10))
;; *X*
;; CL-USER> (defparameter *y* (rnbi rnorm 10))
;; *Y*
;; CL-USER> *y*
;; #<sexp at 0x89A0238, PROTECT=R-PROTECT-UNTIL-USED>
;; CL-USER> (r plot *x* *y*)
;; NIL
;; NIL
;; CL-USER> *y*
;; #<sexp at 0x89A0238, PROTECT=NIL>

;; code used above
(defparameter *x* (r seq 1 10))
(defparameter *y* (rnbi rnorm 10))
*y*
(r plot *x* *y*)
*y*

;; This is for illustrative purposes only.  It is not a "good" use of rnbi.
;; Really, you'll want rnbi to hold anonymous intermeditae results, like:

(r plot *x* (rnbi rnorm 10))

;; Notes:
;; 
;; If the user protects the result of a call with rnb, it is the
;; user's responsibility to delete the sexp when it's no longer needed,
;; using rclg-control:unprotect-sexp.  (It might be better to use a
;; modification of the old safe version that's lying around.)
;; 
;; There is no way to ask R whether an sexp is protected or not.
;; Therefore, there is no real way to enforce the protection.  If the user
;; goes around the API and calls %rf-unprotect-ptr or messes with the
;; description slot (slot-value sexp-holder 'protected), things can easily
;; get out of sync.


;; Examples of function use:


(r "Sys.getenv" "LD_LIBRARY_PATH")
(r "Sys.getenv" "LD_PRELOAD")

(r "ls")
(r "search")

(r "geterrmessage")


;; These don't work if we have library problems.
(r "library" "stats") 
(r library "MASS")
(r "library" "Biobase") 

(setf my.lib "Biobase")
my.lib
(r library my.lib)

(r "ls")

(r "print.default" 3)
(r "rnorm" 10)

;; Working in the R space

(r assign "x" 5)
(r assign "x2" (list 1 2 3 5))

(r assign "x2" #(1 2 3 5 3 4 5))
(r assign "z" "y")

(setf my.r.x2 (r get "x2"))  ;; moving data from R to CL
(r assign "x2" my.r.x2)  ;; moving data from CL to R

(r "get" "x")
(r get "x2")
(r "get" "z")
(r get "z")
(r "ls")


(r assign "my.x" (r rnorm 10))
(r assign "my.x" (rnb rnorm 10))

(r get "my.x")




;; More sophisticated computation

(r "plot" #(2 3 3 2 1) #(3 5 7 3 2))

(r plot (list 1 2 3 4 5) (list 1 2 3 4 5) :main "My title")
(r plot :x (list 1 2 3 4 5) :y (list 5 4 3 4 5) :main "My title")

(r plot :y (list 5 4 3 4 5)  :x (list 1 2 3 4 5) :main "My title")

(r plot (rnb rnorm 10) (rnb rnorm 10)
   :main "silly" :xlab "xlabel" :ylab "ylabel")

(aref (r rnorm 10) 3)


;; create a CL function r-hist that calls the R function hist on a
;; sequence, returning no results.  The keywords :main and :xlab are
;; passed with default values nil, and the other keywords are passed with
;; the chosen values.
(def-r-call (r-hist hist :no-result sequence) main
  xlab (breaks 50) (probability t) (col "blue"))
;; then the function can be called:
(r-hist (rnbi rnorm 1000))
;; for instance.


;;;#5 Code (really, applications/tasks) that needs to work (i.e. be
;;;   do-able).


;;; Need to be able to run!
(r assign "my.df" (r read.table "testdata.csv"))
(r summary "my.df")



;;; Model fitting?

(rnb as.formula "x ~ y") ; fine
(rnbi as.formula "x ~ y") ; fine
(r as.formula "x ~ y") ; barfs

(rnb data.frame
     :x (r rnorm 10)
     :y (r rnorm 10)) ; fine
(r data.frame
   :x (r rnorm 10)
   :y (r rnorm 10)) ; fine

(r summary (r t (r data.frame
		   :x (r rnorm 10)
		   :y (r rnorm 10)))) ; fine ; fine ; no.

(r lm
   :formula (rnb as.formula "x ~ y")
   :data (rnb data.frame
	    :x (r rnorm 10)
	    :y (r rnorm 10)))


;;; How to handle connections?


;;; How to handle S4 objects?
;;; Hook into the conversion?


;;; how do we terminate the R session?
(r "q" "y")






;;;#5 Old useless code.



;;; Local variables:
;;; mode: outline-minor
;;; outline-header-prefix: ";;;"
;;; End:
