;; Copyright (c) 2006 Carlos Ungil

;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
;; LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
;; OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

(in-package :rcl)

;; for CMUCL: the shell variable R_HOME has to be set to the value
;; below *before* the lisp interpreter is executed
(eval-when (:compile-toplevel :load-toplevel :execute)
  (defvar *r-home* 
    #+cffi-features:darwin "/Library/Frameworks/R.framework/Resources/"
    #-cffi-features:darwin "/usr/lib/R/")
  (defvar *r-lib-path* 
    (concatenate 'string *r-home* "lib/"))
  (defvar *r-lib* 
    (concatenate 'string *r-lib-path* "libR"
		 #+cffi-features:darwin ".dylib"
		 #-cffi-features:darwin ".so")))
    
