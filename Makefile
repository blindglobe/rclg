##FILES= {src/*.lisp}

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
	git push -v git+ssh://repo.or.cz/srv/git/rclg.git master:master tonylocal:tonylocal

tarball:
##	git tar-tree R_0-1 rclg-0.1 | gzip >rclg-0.1.tar.gz   
##  'git-archive' '--format=tar' '--prefix=rclg-0.1/' 'R_0-1'

clean: 
	rm *~ */*~

