function launch_demo(){

  echo "In launch_demo"
  HOME=$1
  SRC=/mdb/$2/$3
  TGT=/etc/my.cnf.d
  
  for s in {mdbsrv1,mdbsrv2,mdbsrv3,mdbsrv4};
  do
    case ${s} in
      mdbsrv1) echo "Configuring the spider node ..."
               docker exec -i ${s} /bin/sh -c 'mysql < /usr/share/mysql/install_spider.sql'
               docker exec -i ${s} /bin/sh -c 'mysql < '${SRC}'/spider_head.sql'
               docker exec -i ${s} /bin/sh -c 'systemctl restart mariadb'
               ${HOME}/scripts/strtTerm.osa "docker exec -it ${s} mysql test"
      ;;
      mdbsrv2) echo "Configuring spider node 1 ..."
               docker exec -i ${s} /bin/sh -c 'mysql < '${SRC}'/spider_node.sql'
               docker exec -i ${s} /bin/sh -c 'systemctl restart mariadb'
               ${HOME}/scripts/strtTerm.osa "docker exec -it ${s} mysql test"
      ;;
      mdbsrv3) echo "Configuring spider node 2 ..."
               docker exec -i ${s} /bin/sh -c 'mysql < '${SRC}'/spider_node.sql'
	       docker exec -i ${s} /bin/sh -c 'systemctl restart mariadb'
	       ${HOME}/scripts/strtTerm.osa "docker exec -it ${s} mysql test"
      ;;
      mdbsrv4) echo "Configuring spider node 3 ..."
               docker exec -i ${s} /bin/sh -c 'mysql < '${SRC}'/spider_node.sql'
               docker exec -i ${s} /bin/sh -c 'systemctl restart mariadb'
               ${HOME}/scripts/strtTerm.osa "docker exec -it ${s} mysql test"
      ;;
    esac
  done

  cat ${HOME}/$2/$3/readme.guey
}

# launch_demo  "/Users/Shared" mdbtx spider
