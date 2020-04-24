function launch_demo(){

  HOME=$1 
  SRC=${HOME}/$2/$3
  TGT=/mdb/$2/$3

  echo -e "HOME DIRECTORY (failoverMaster) = ${HOME}"
  
  sleep 5

  for s in {mdbsrv1,mdbsrv2,mdbsrv3,mdbmxscl};
    do
      case ${s} in
        mdbsrv1) docker exec -i ${s} cp ${TGT}/server.cnf.srv1 /etc/my.cnf.d/server.cnf
                 docker exec -i ${s} /bin/sh -c 'systemctl start mariadb'
                 docker exec -i ${s} /bin/sh -c 'mariadb < /mdb/scripts/cr_users.sql'
                 ${HOME}/scripts/strtTerm.osa "docker exec -it ${s} mariadb -u mdb -pletmein -h mdbsrv1"
        ;;
        mdbsrv2) docker exec -i ${s} cp ${TGT}/server.cnf.srv2 /etc/my.cnf.d/server.cnf
                 docker exec -i ${s} /bin/sh -c 'systemctl start mariadb'
                 sleep 5
                 docker exec -i ${s} /bin/sh -c 'mariadb < /mdb/scripts/strt_rep.sql'
                 ${HOME}/scripts/strtTerm.osa "docker exec -it ${s} mariadb -u mdb -pletmein -h mdbsrv2"
        ;;
        mdbsrv3) docker exec -i ${s} cp ${TGT}/server.cnf.srv3 /etc/my.cnf.d/server.cnf
                 docker exec -i ${s} /bin/sh -c 'systemctl start mariadb'
                 sleep 5
                 docker exec -i ${s} /bin/sh -c 'mariadb < /mdb/scripts/strt_rep.sql'
                 ${HOME}/scripts/strtTerm.osa "docker exec -it ${s}  mariadb -u mdb -pletmein -h mdbsrv3"
        ;;
        mdbmxscl) docker exec -i mdbmxscl cp ${TGT}/maxscale.cnf /etc/maxscale.cnf
                  sleep 5
                  docker exec -i ${s} /bin/sh -c 'systemctl restart maxscale'
                  ${HOME}/scripts/strtTerm.osa "docker exec -it ${s} bash"
                  ${HOME}/scripts/strtTerm.osa "docker exec -it ${s}  watch -n 1 -d maxctrl list servers"
        ;;
      esac
    done
  
  cat ${SRC}/readme.guey
}

#launch_demo /Users/Shared  maxscl failover
