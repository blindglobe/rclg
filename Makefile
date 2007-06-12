##FILES= {src/*.lisp}
VERS=0.1

FILES= r-cl/src/rclg-abstractions.lisp  r-cl/src/rclg-cffi-sysenv.lisp \
   r-cl/src/rclg-convert.lisp r-cl/src/rclg-init.lisp r-cl/src/rclg-types.lisp \
   r-cl/src/rclg.lisp r-cl/src/rclg-access.lisp r-cl/src/rclg-control.lisp  \
   r-cl/src/rclg-foreigns.lisp  r-cl/src/rclg-load.lisp  r-cl/src/rclg-util.lisp \
   r-cl/rclg.asd  r-cl/README r-cl/COPYING 


default : 
	echo "Select a target: "
	echo "    push"
	echo "    clean (not implemented)"
	echo "    build (not implemented)"
	echo "    install (not implemented)"
	echo "	  tarball (not implemented)"




push:
	git push -v --all git+ssh://repo.or.cz/srv/git/rclg.git


tarball-release:
	git archive -v --format=tar --prefix=rclg-$(VERS)/ release \
		gzip >rclg-release.tar.gz

tarball-version:
	git archive -v --format=tar --prefix=rclg-$(VERS)/ release \
		gzip >rclg-$(VERS).tar.gz

clean: 
	rm *~ */*~

