(defpackage "RCLG-UTIL"
  (:use :rclg :common-lisp 
	:middleangle.cl.utilities.utilities)
  (:export :r-plot :r-image :r-hist :r-multiple-lines))

(in-package :rclg-util)

(def-r-call (r-plot plot :no-result sequence) 
    (xlab "") (ylab "") (type "l"))

(def-r-call (r-hist hist :no-result sequence) 
    main xlab (breaks 50) (probability t) (col "blue"))

(defparameter *r-default-image-colormap* 
  (r-do-not-convert (r gray (r seq .05 .95 :by .05))))

(def-r-call (r-image image :no-result data) 
    (col *r-default-image-colormap*) (xlab "") (ylab ""))

(defun r-multiple-lines (lines &key (x nil) (log "")
			 (xlab "") (ylab "") (main "") (type "o") (lwd 2)
			 (names nil) (legend-xy nil) (expand-top .1d0)
			 (expand-bottom .1d0))
  "Makes a plot of multiple lines (contained in lines).  The y limits
are computed by expanding the minimum and maximum values in lines by
expand-range.  Each line must have the same number of points.  A
legend is only created if both names AND legend-xy are non-NIL."
  (let* ((index (1-n-vec (length (first lines))))
	 (x (or x index)))
    (r-plot (first lines) :x x :log log :xlab xlab :ylab ylab :main main :type type
	    :ylim (compute-expanded-range lines expand-top expand-bottom)
	    :lwd lwd)
    ;; Plot remaining lines
    (let ((i 2))
      (dolist (l (rest lines))
	(r lines l :x x :type type :col i :lwd lwd :lty i :pch i)
	(incf i)))
    (when (and names legend-xy)
      (r legend (first legend-xy) (second legend-xy) names
	 :col index :lwd lwd :lty (1-n-list (length names))))
    nil))

(defun compute-expanded-range (seq-of-seqs expand-top expand-bottom)
  (mvb (min max) (compute-range seq-of-seqs)
       (let ((diff (- max min)))
	 (list (- min (* diff expand-bottom))
	       (+ max (* diff expand-top))))))

(defun compute-range (seq-of-seqs)
  (values (extremal #'min seq-of-seqs)
	  (extremal #'max seq-of-seqs)))

(defun extremal (func seq-of-seqs)
  (reduce func 
	  (vecmap (lambda (seq) 
		    (reduce func seq)) 
		  seq-of-seqs)))
