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
	   add-new-cffi-lib-directory
	   posix-setrlimit posix-getrlimit))

(in-package :rclg-cffi-sysenv)

;;;* Environmental Variables using CFFI
;(use-package :cffi)
(defcfun ("getenv" posix-getenv) :string
  (envname :string))

(defcfun ("setenv" posix-setenv) :int
  (envname :string) (envval :string) (overwrite :int))


;;;* Library loading for weird cases

;; Could be a string, pathname, or list consisting of strings and
;; pathnames.  Works on both CFFI load path and system "LD_LIBRARY_PATH".
;;(add-new-cffi-lib-directory #P"/usr/lib/R/library/grDevices/libs/") ; test, works
;;(add-new-cffi-directory "/lib")  ;test, works.
;;(add-new-cffi-lib-directory #P"/usr/lib/" "/usr/local/lib") ; test, works

(defgeneric add-new-cffi-lib-directory (dir)
  (:documentation "Add directory(ies) to CFFI load path and LD_LIBRRARY_PATH."))

(defmethod add-new-cffi-lib-directory ((dir string))
  (pushnew (pathname dir)
	   *foreign-library-directories*
	   :test #'equal)
  (posix-setenv "LD_LIBRARY_PATH"
		(concatenate 'string
			     dir
			     ":" ;; if LD_LIBRARY_PATH is null, then we can drop this trailing ":"
			     (posix-getenv "LD_LIBRARY_PATH"))
		1))

(defmethod add-new-cffi-lib-directory ((dir pathname))
  (pushnew dir
	   *foreign-library-directories*
	   :test #'equal)
  (posix-setenv "LD_LIBRARY_PATH"
		(concatenate 'string
			     (namestring dir)
			     ":" ;; if LD_LIBRARY_PATH is null, then we can drop this trailing ":"
			     (posix-getenv "LD_LIBRARY_PATH"))
		1))

;; if a list, break down into components
(defmethod add-new-cffi-lib-directory ((dir list))
  (dolist (adir dir)
    (add-new-cffi-lib-directory adir)))

;; need to inlcude a default operation which simply aborts, indicating bad inputs.

;;(add-new-cffi-lib-directory (list #p"/usr" "/usr/local"))

;;;* RESOURCES
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
