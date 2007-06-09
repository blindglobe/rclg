default : 
	echo "Select a target: "
	echo "    push"
	echo "    clean (not implemented)"
	echo "    build (not implemented)"
	echo "    install (not implemented)"


push:
	git push -v git+ssh://repo.or.cz/srv/git/rclg.git master:master tonylocal:tonylocal

package:
##	git tar-tree R_0-1 rclg-0.1 | gzip >rclg-0.1.tar.gz   
##  'git-archive' '--format=tar' '--prefix=rclg-0.1/' 'R_0-1'

