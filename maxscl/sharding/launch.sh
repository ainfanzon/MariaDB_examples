function launch_demo(){

  echo "In launch_demo"
  HOME=$1
  SRC=/mdb/$2/$3
  TGT=/etc/my.cnf.d

  for s in {mdbsrv1,mdbsrv2,mdbsrv3,mdbmxscl};
  do
    case ${s} in
      mdbsrv1) echo "Starting mdbsrv1"
               docker exec -i ${s} cp ${SRC}/server.cnf.srv1 ${TGT}/server.cnf
               docker exec -i ${s} /bin/sh -c 'systemctl start mariadb'
               sleep 5
               docker exec -i ${s} /bin/sh -c 'mariadb < /mdb/scripts/cr_users.sql'
               docker exec -i ${s} /bin/sh -c 'mariadb < '$SRC'/acme_amer.sch'
               ${HOME}/scripts/strtTerm.osa "docker exec -it mdbsrv1 mariadb"
      ;;
      mdbsrv2) echo "Starting mdbsrv2"
               docker exec -i ${s} cp ${SRC}/server.cnf.srv2 ${TGT}/server.cnf
               docker exec -i ${s} /bin/sh -c 'systemctl start mariadb'
               sleep 5
               docker exec -i ${s} /bin/sh -c 'mariadb < /mdb/scripts/cr_users.sql'
               docker exec -i ${s} /bin/sh -c 'mariadb < '$SRC'/acme_apac.sch'
               ${HOME}/scripts/strtTerm.osa "docker exec -it mdbsrv2 mariadb"
      ;;
      mdbsrv3) echo "Starting mdbsrv3"
               docker exec -i ${s} cp ${SRC}/server.cnf.srv3 ${TGT}/server.cnf
               docker exec -i ${s} /bin/sh -c 'systemctl start mariadb'
               sleep 5
               docker exec -i ${s} /bin/sh -c 'mariadb < /mdb/scripts/cr_users.sql'
               docker exec -i ${s} /bin/sh -c 'mariadb < '$SRC'/acme_emea.sch'
               ${HOME}/scripts/strtTerm.osa "docker exec -it mdbsrv3 mariadb"
      ;;
      mdbmxscl) echo "Starting MaxScale"
                docker exec -i mdbmxscl cp ${SRC}/maxscale.cnf /etc/maxscale.cnf
                docker exec -i ${s} /bin/sh -c 'systemctl restart maxscale'
                ${HOME}/scripts/strtTerm.osa "docker exec -it mdbmxscl bash" 
      ;;
    esac
  done

  cat ${HOME}/$2/$3/readme.guey
}

#launch_demo /Users/Shared  maxscl failover
