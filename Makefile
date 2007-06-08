default : 
	echo "Select a target: "
	echo "    push"
	echo "    clean"
	echo "    build (not implemented)"
	echo "    install (not implemented)"


push:
	git push -v git+ssh://repo.or.cz/srv/git/rclg.git master:master tonylocal:tonylocal
