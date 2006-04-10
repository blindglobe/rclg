;; -*- mode: lisp -*-

;;; (c) 2005--2006, Cyrus Harmon, all rights reserved.
;;; Author: Cyrus Harmon
;;; Maintainers: Cyrus Harmon and AJ Rossini

;;; Purpose: FFI loader.

(in-package :clsr)

(defun uffi-load-r-library (lib)
  (unless (uffi:load-foreign-library 
           (uffi:find-foreign-library
            lib clsr-system::*link-library-directories*
            :types '("so" "dylib" ""))
           :supporting-libraries '("c")
           :module lib
           :force-load t)
    (error "Unable to load R library")))

(uffi-load-r-library "libR")


