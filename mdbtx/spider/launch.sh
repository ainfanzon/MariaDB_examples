function launch_demo(){

  echo "In launch_demo"
  HOME=$1
  SRC=/mdb/$2/$3
  TGT=/etc/my.cnf.d
  
  for s in {mdbsrv1,mdbsrv2,mdbsrv3,mdbsrv4};
  do
    case ${s} in
      mdbsrv1) echo "Configuring the spider node ..."
               docker exec -i ${s} cp ${SRC}/server.cnf.srv1 /etc/my.cnf.d/server.cnf
               docker exec -i ${s} /bin/sh -c 'systemctl restart mariadb'
               docker exec -i ${s} /bin/sh -c 'mariadb < /usr/share/mysql/install_spider.sql'
               docker exec -i ${s} /bin/sh -c 'mariadb < '${SRC}'/spider_head.sql'
               ${HOME}/scripts/strtTerm.osa "docker exec -it ${s} mariadb test"
      ;;
      mdbsrv2) echo "Configuring spider node 1 ..."
               docker exec -i ${s} cp ${SRC}/server.cnf.srv2 /etc/my.cnf.d/server.cnf
               docker exec -i ${s} /bin/sh -c 'systemctl restart mariadb'
               docker exec -i ${s} /bin/sh -c 'mariadb < '${SRC}'/spider_node.sql'
               ${HOME}/scripts/strtTerm.osa "docker exec -it ${s} mariadb test"
      ;;
      mdbsrv3) echo "Configuring spider node 2 ..."
               docker exec -i ${s} cp ${SRC}/server.cnf.srv3 /etc/my.cnf.d/server.cnf
	       docker exec -i ${s} /bin/sh -c 'systemctl restart mariadb'
               docker exec -i ${s} /bin/sh -c 'mariadb < '${SRC}'/spider_node.sql'
	       ${HOME}/scripts/strtTerm.osa "docker exec -it ${s} mariadb test"
      ;;
      mdbsrv4) echo "Configuring spider node 3 ..."
               docker exec -i ${s} cp ${SRC}/server.cnf.srv4 /etc/my.cnf.d/server.cnf
               docker exec -i ${s} /bin/sh -c 'systemctl restart mariadb'
               docker exec -i ${s} /bin/sh -c 'mariadb < '${SRC}'/spider_node.sql'
               ${HOME}/scripts/strtTerm.osa "docker exec -it ${s} mariadb test"
      ;;
    esac
  done

  cat ${HOME}/$2/$3/readme.guey
}

# launch_demo  "/Users/Shared" mdbtx spider
