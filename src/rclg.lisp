;;; RCLG: R-CommonLisp Gateway

;;; Copyright (c) --2006, rif@mit.edu.  All Rights Reserved.
;;; Author: rif@mit.edu
;;; Maintainers: rif@mit.edu, AJ Rossini <blindglobe@gmail.com>
;;; License: TBD

;;; Intent: This provides package definitions through rclg-user for
;;; rclg.

(defpackage :rclg
  (:use :common-lisp
	:rclg-control :rclg-convert
	:rclg-foreigns :rclg-init :rclg-cffi-sysenv
	:rclg-load :rclg-types :rclg-util)
  (:export :r :rnb :rnbi :rnr
	   :start-rclg :*r-started* :update-R
	   :sexp :def-r-call))

;;; User package for testing/evaluation.

(defpackage :rclg-user
  (:use :common-lisp :rclg))
