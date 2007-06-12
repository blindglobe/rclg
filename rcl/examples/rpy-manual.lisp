;;; 2.2 Invocation

;; >>> from rpy import *

(asdf:oos 'asdf:load-op :rcl)

(in-package :rcl)

(r-init)

;; >>> r.wilcox_test
;; <Robj object at 0x8a9e120>

(r-function "wilcox.test") 
;;> #.(SB-SYS:INT-SAP #X07354268) 
;; retrieves the function object
;; eventually a "r object" should be returned
;; because pointers are not identified as such on allegro
;; to be able to call strings or R objects directly

;; >>> r.wilcox_test([1,2,3], [4,5,6])
;; {'p.value': 0.10000000000000001, 'statistic': {'W': 0.0},
;; 'null.value': {'mu': 0.0}, 'data.name': 'c(1, 2, 3) and c(4, 5, 6)',
;; 'alternative': 'two.sided', 'parameter': None, 'method':
;; 'Wilcoxon rank sum test'}

(r "wilcox.test" '(1 2 3) '(4 5 6))
;;> ((0.0d0) NIL (0.1d0) (0.0d0) ("two.sided") ("Wilcoxon rank sum test") ("c(1, 2, 3) and c(4, 5, 6)"))
;; also prints this to stdout
;; (("statistic" "parameter" "p.value" "null.value" "alternative" "method"
;;   "data.name")
;;  (("htest") NIL :SYMBOL) :SYMBOL) 
;; (("W") NIL :SYMBOL) 
;; (("mu") NIL :SYMBOL) 
;; THERE IS QUITE A LOT OF WORK TO DO HERE

;; macro (r ...) expands to (r-obj-decode (with-r-messages-to-stdout (r-funcall ...)))
;; the R-stdout, R-stderr should be redirected to lisp streams?

;; >>> r.seq(1, 3, by=0.5)
;; [1.0, 1.5, 2.0, 2.5, 3]

(r "seq" 1 3 :by 0.5)  
;; also (r "seq" 1 3 '(:by 0.5))
;;> (1.0d0 1.5d0 2.0d0 2.5d0 3.0d0)


;; >>> r.plot()
;; Traceback (most recent call last):
;; File "<stdin>", line 1, in ?
;; rpy.RException: Error in function (x, ...)  : Argument "x" is missing,
;; with no default

(r "plot")  ;; SIMPLE ERROR "error calling plot"
;; we are just getting an error code from r-tryeval and raising in that case
;; our own (error "error calling ~A" function))) 

(r* "plot")


;;; 2.3 Small example

; >>> from rpy import *
; >>>
; >>> degrees = 4
; >>> grid = r.seq(0, 10, length=100)
; >>> values = [r.dchisq(x, degrees) for x in grid]
; >>> r.par(ann=0)
; >>> r.plot(grid, values, type='lines')

(in-package :rcl)

(r-init)

(let* ((degrees 4)
       (grid (r "seq" 0 10 :length 100))
       (values (loop for x in grid collect (r% "dchisq" x degrees))))
  (r "par" :ann 0)
  (r "plot" grid values :type "lines"))