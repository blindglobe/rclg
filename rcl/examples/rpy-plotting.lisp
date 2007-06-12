;; From  http://rpy.sourceforge.net/documentation.html

;; Plotting with RPy 
;; by Titus Brown
;; http://rpy.sourceforge.net/plotting-with-RPy.html

;;
;; Getting started
;;

#|
from rpy import *

x = range(0, 10)
y = [ 2*i for i in x ]

r.plot_default(x, y)
|#

(require :rcl)

(in-package :rcl)

(r-init)

(let* ((x (loop for i from 0 below 10 collect i))
       (y (loop for i in x collect (* 2 i))))
  (r "plot.default" x y))


;; if there is no X session, R might be plotting to a PostScript file
;; in the current directory, in that case you'll need to close the device
;; (r "dev.off")

;;
;; Getting moderately tricky
;;

#|
from rpy import *
import math

x = range(0, 10)
y1 = [ 2*i for i in x ]
y2 = [ math.log(i+1) for i in x ]

r.plot_default(x, y1, col="blue", type="o")
r.points(x, y2, col="red", type="o")
|#

;; we can also use vectors instead of lists:
(let* ((x (apply #'vector (loop for i from 0 below 10 collect i)))
       (y1 (map 'vector (lambda (x) (* 2 x)) x))
       (y2 (map 'vector (lambda (x) (log (1+ x))) x)))
  ;; pairs of keywords and value can be passed in two different ways:
  (r "plot.default" x y1 :col "blue" :type "o")
  (r "points" x y2 '(:col . "red") '(:type . "o")))

;;
;; Axis labels and titles
;;

#|
from rpy import *
import math

x = range(0, 10)
y1 = [ 2*i for i in x ]
y2 = [ math.log(i+1) for i in x ]

r.plot_default(x, y1, col="blue", type="o")
r.points(x, y2, col="red", type="o")

xlabels = [ "#%d" % (i,) for i in x ]
r.axis(1, at = x, label=xlabels, lwd=1, cex_axis=1.15)
r.title("My Plot")
|#

(let* ((x (loop for i from 0 below 10 collect i))
       (y1 (mapcar (lambda (x) (* 2 x)) x))
       (y2 (mapcar (lambda (x) (log (1+ x))) x))
       (xlabels (mapcar (lambda (x) (format nil "#~D" x)) x)))
  (r "plot.default" x y1 :col "blue" :type "o")
  (r "points" x y2 :col "red" :type "o")
  (r "axis" 1 :at x :label xlabels :lwd 1 :cex.axis 1.15)
  (r "title" "My Plot"))

;; does the example above work as expected?
;; the original labels and the new ones overlap for some ticks
;; I think the axis options has to be used to not print the labels
;; twice (see test-plot below)

;;
;; Outputting to a file
;;

#|
You can set things up to output to a file by putting either of
these commands in front of the plot_default command:

outfile = "somefile.ps"
r.postscript(outfile, paper='letter')

or

outfile = "somefile.png"
r.bitmap(outfile, res=200)

The former writes a postscript file, and the latter writes a PNG
file. Oh, and be sure to call r.dev_off before using the file --
that will flush any unwritten data
|#

(let* ((x (loop for i from 0 below 10 collect i))
       (y1 (mapcar (lambda (x) (* 2 x)) x))
       (y2 (mapcar (lambda (x) (log (1+ x))) x))
       (xlabels (mapcar (lambda (x) (format nil "#~D" x)) x)))
  (r "postscript" "somefile.ps" :paper "letter")
  (r "plot.default" x y1 :col "blue" :type "o")
  (r "points" x y2 :col "red" :type "o")
  (r "axis" 1 :at x :label xlabels :lwd 1 :cex.axis 1.15)
  (r "title" "My Plot")
  (r "dev.off"))


;;
;; more interesting RCL example
;; using some macros to control streams and devices

(defun test-plot (&optional (file-type :pdf) (file "/tmp/test"))
  (let*  ((x (loop for i from 0 below 10 collect i))
	  (y1 (mapcar (lambda (x) (* x 2)) x))
	  (y2 (mapcar (lambda (x) (log (1+ x))) x))
	  (labels (mapcar (lambda (x) (format nil "~R" x)) x)))
    (with-device (file file-type) 
      ;; this opens (and closes) a device of one of the following types
      ;; :ps, :pdf, :png, :jpg (or :jpeg), :xfig, :pictex
      ;; (the correspoding extension is added automatically to the filename)
      (r "plot.default" x y1 :xlab "horizontal" :ylab "vertical" 
	 :col "blue" :type "o" :axes nil)
      (r "points" x y2  :col  "red" :type "o")
      (r "axis" 1 :at x :label labels :lwd 1 :cex.axis 0.75)
      (r "axis" 2)
      (r "box")
      (r "title" "Plotting from Common Lisp"))))
    