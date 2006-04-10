;; -*- mode:lisp -*-

;;; (c) 2005--2006, Cyrus Harmon, all rights reserved.
;;; Author: Cyrus Harmon
;;; Maintainers: Cyrus Harmon and AJ Rossini

;;; Purpose: string <-> R command management

(in-package :clsr)

(defun %parse-r-command (command-string)
  (let ((cmd-sexp (r::|Rf_allocVector| r::|STRSXP| 1))
        (parse-status (sb-alien:make-alien r::|ParseStatus|)))
    (r::|Rf_protect| cmd-sexp)
    (gcc-xml-ffi::with-alien-signed-string (cmd command-string)
      (r::|SET_STRING_ELT| cmd-sexp 0 (r::|Rf_mkChar| cmd))
      (let ((cmd-expr (r::|R_ParseVector| cmd-sexp -1 parse-status)))
        cmd-expr))))

(defun assemble-r-parse (str)
  (let ((args (gcc-xml-ffi::with-alien-signed-string (astr str)
                (r::|Rf_mkString| astr))))
    (let ((e (r::|Rf_allocVector| r::|LANGSXP| 2)))
      (r::|SETCAR| e
          (gcc-xml-ffi::with-alien-signed-string (parse "parse")
            (r::|Rf_install| parse)))
      (r::|SETCADR| e args)
      (gcc-xml-ffi::with-alien-signed-string (text "text")
        (r::|SET_TAG| (r::|CDR| e) (r::|Rf_install| text)))
      e)))

(defun eval-r-command (command-string)
  (let ((cmd-sexp (r::|Rf_allocVector| r::|STRSXP| 1))
        (parse-status (sb-alien:make-alien r::|ParseStatus|)))
    (r::|Rf_protect| cmd-sexp)
    (gcc-xml-ffi::with-alien-signed-string (cmd command-string)
      (r::|SET_STRING_ELT| cmd-sexp 0 (r::|Rf_mkChar| cmd))
      (let ((cmd-expr (r::|R_ParseVector| cmd-sexp -1 parse-status)))
        (r::|Rf_protect| cmd-expr)
        (unwind-protect
             (if (equal (sb-alien:deref parse-status) 'r::|PARSE_OK|)
                 (unwind-protect
                      (let ((ans)
                            (result (sb-alien:make-alien sb-alien:int)))
                        (dotimes (i (r::|Rf_length| cmd-expr))
                          (setf ans (r::|R_tryEval| (r::|VECTOR_ELT| cmd-expr i) r::|R_GlobalEnv| result)))
                        ans)
                   (sb-alien:deref parse-status))
                 (error 'r-error :details "R_ParseVector failed"))
          (r::|Rf_unprotect| 2))))))

(defun parse-r-expression (expression-string)
    (let ((expn-sexp (assemble-r-parse expression-string)))
      (r::|Rf_protect| expn-sexp)
      (unwind-protect
           (let ((ans)
                 (error-occurred (sb-alien:make-alien sb-alien:int))) 
             (setf ans (r::|R_tryEval| expn-sexp r::|R_GlobalEnv| error-occurred))
             (when error-occurred (error 'r-error :details "R_tryEval failed"))
             ans)
        (r::|Rf_unprotect| 1))))

(defun try-eval (expn-sexp)
  (r::|Rf_protect| expn-sexp)
  (let ((ans))
    (dotimes (i (r::|LENGTH| expn-sexp) ans)
      (unwind-protect
           (let ((error-occurred (sb-alien:make-alien sb-alien:int)))
             (setf ans (r::|R_tryEval| (r::|VECTOR_ELT| expn-sexp i)
			   r::|R_GlobalEnv| error-occurred))
             (when (/= (sb-alien:deref error-occurred) 0)
               (error 'r-error :details "R_tryEval failed"))
             ans)
        (r::|Rf_unprotect| 1)))))

(defmacro with-parsed-r-expression ((parsed expression-string) &body body)
  (ch-util::with-unique-names (expn-sxp error-occurred)
    `(let ((,expn-sxp (assemble-r-parse ,expression-string)))
       (r::|Rf_protect| ,expn-sxp)
       (unwind-protect
            (let* ((,error-occurred (sb-alien:make-alien sb-alien:int))
                   (,parsed (r::|R_tryEval| ,expn-sxp r::|R_GlobalEnv| ,error-occurred)))
              (when (/= (sb-alien:deref ,error-occurred) 0)
                (error 'r-error :details "R_tryEval failed"))
              (r::|Rf_protect| ,parsed)
              (unwind-protect
                   (progn
                     ,@body)
                (r::|Rf_unprotect| 1)))
         (r::|Rf_unprotect| 1)))))

(defmacro with-evaled-r-expression ((evaled expn-sxp) &body body)
  (ch-util::with-unique-names (i error-occurred)
    `(unless (sb-alien:null-alien ,expn-sxp)
       (let ((,evaled))
         (dotimes (,i (r::|LENGTH| ,expn-sxp) ,evaled)
           (let ((,error-occurred (sb-alien:make-alien sb-alien:int)))
             (setf ,evaled (r::|R_tryEval|
                               (r::|VECTOR_ELT| ,expn-sxp ,i)
                               r::|R_GlobalEnv| ,error-occurred))
             (when (/= (sb-alien:deref ,error-occurred) 0)
               (error 'r-error :details "R_tryEval failed"))))
         (r::|Rf_protect| ,evaled)
         (unwind-protect
              (progn
                ,@body)
           (r::|Rf_unprotect| 1))))))
  
(defmacro with-r-call ((answer cmd) &body body)
  (ch-util::with-unique-names (expn-sxp)
    `(with-parsed-r-expression (,expn-sxp ,cmd)
       (with-evaled-r-expression (,answer ,expn-sxp)
         (progn
           ,@body)))))
