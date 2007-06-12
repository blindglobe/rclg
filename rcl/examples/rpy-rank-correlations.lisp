;; From http://rpy.sourceforge.net/documentation.html

;; Using Python (and R) to calculate Rank Correlations 
;; by Peter Cock (added 2005-08-27)
;; http://www2.warwick.ac.uk/fac/sci/moac/currentstudents/peter_cock/python/rank_correlations/

#|
>>> import rpy
>>> x = [5.05, 6.75, 3.21, 2.66]
>>> y = [1.65, 26.5, -5.93, 7.96]
>>> z = [1.65, 2.64, 2.64, 6.95]
>>> print rpy.r.cor(x, y, method="spearman")
0.4
>>> print rpy.r.cor(x, z, method="spearman")
-0.632455532034
>>> print rpy.r.cor(x, y, method="kendall")
0.333333333333
>>> print rpy.r.cor(x, z, method="kendall")
-0.547722557505
|#

(require :rcl)

(in-package :rcl)

(r-init)

(let ((x '(5.05 6.75 3.21 2.66))
      (y '(1.65 26.5 -5.93 7.96))
      (z '(1.65 2.64 2.64 6.95)))
  (list
   (r "cor" x y :method "spearman")
   (r "cor" x z :method "spearman")
   (r "cor" x y :method "kendall")
   (r "cor" x z :method "kendall")))

;; => (0.4d0 -0.6324555320336759d0 0.33333333333333337d0 -0.5477225575051661d0)