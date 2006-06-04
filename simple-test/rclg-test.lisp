(operate 'load-op :cffi)
(use-package :cffi)
(operate 'load-op :rclg)
(unintern 'finalize)
(unintern 'cancel-finalization)
(use-package :rclg-foreigns)

(rclg-init::start-rclg)
(with-foreign-string (ident-foreign "rnorm")
  (let ((install (%rf-install ident-foreign)))
    (format t "rf-install: ~A~%" install)
    (let ((foreign-value (%rf-find-var install *r-global-env*)))
      (format t "rf-find-fun ~A~%" foreign-value)
      (format t "pointer: ~A~%" 
	      (cffi-sys:pointer-address foreign-value))
      (format t "unbound: ~A~%" 
	      (cffi-sys:pointer-address *r-unbound-value*)))))
