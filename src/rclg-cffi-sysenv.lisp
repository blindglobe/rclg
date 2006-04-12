;;; RCLG: R-CommonLisp Gateway

;;; Copyright (c) --2006, rif@mit.edu.  All Rights Reserved.
;;; Author: rif@mit.edu
;;; Maintainers: rif@mit.edu, AJ Rossini <blindglobe@gmail.com>

;;; Intent: initialize environment stuff.  Purely developer level, no
;;; user tools.

(asdf:oos 'asdf:load-op 'cffi) ;; FIXME:AJR: Ugly hack.  Do it right!

(defpackage :rclg-cffi-sysenv
  (:use :common-lisp :cffi)
  (:export posix-setenv posix-getenv
	   posix-setrlimit posix-getrlimit))

(in-package :rclg-cffi-sysenv)


;;; Set Environmental Variables using CFFI

(defcfun ("getenv" posix-getenv) :string
  (envname :string))

(defcfun ("setenv" posix-setenv) :int
  (envname :string) (envval :string) (overwrite :int))


#|
  #include <sys/time.h>
  #include <sys/resource.h>

       int getrlimit(int resource, struct rlimit *rlim);
       int setrlimit(int resource, const struct rlimit *rlim);

DESCRIPTION
       getrlimit()  and  setrlimit()  get  and  set resource limits respectively.
       Each resource has an associated soft and hard limit,  as  defined  by  the
       rlimit structure (the rlim argument to both getrlimit() and setrlimit()):

            struct rlimit {
                rlim_t rlim_cur;  /* Soft limit */
                rlim_t rlim_max;  /* Hard limit (ceiling for rlim_cur) */
            };
|#

;;;* Resource limit manipulation (esp for stack)

(defctype rlim_t :int
  :documentation "numbers describing range limits")

(defcstruct rlimitStruct
   (rlim_cur rlim_t)  ;; soft limit
   (rlim_max rlim_t)) ;; hard limit

(defcfun ("getrlimit" posix-getrlimit) :int
  (resource :int) (rlimit rlimitStruct))

(defcfun ("setrlimit" posix-setrlimit) :int
  (resource :int) (rlimit rlimitStruct))
