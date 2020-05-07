function launch_demo(){

  HOME=$1 
  SRC=${HOME}/$2/$3
  TGT=/mdb/$2/$3

  echo -e "HOME DIRECTORY (failoverGalera) = ${HOME}"
  
  for s in {mdbsrv1,mdbsrv2,mdbsrv3};
  do
    docker exec -i ${s} /bin/sh -c 'systemctl stop mariadb'
  done

  for s in {mdbsrv1,mdbsrv2,mdbsrv3,mdbmxscl};
    do
      case ${s} in
        mdbsrv1) echo "Configuring the first galera  node ..."
                 docker exec -i ${s} cp ${TGT}/server.cnf.srv1 /etc/my.cnf.d/server.cnf
                 docker exec -i ${s} /bin/sh -c 'systemctl stop mariadb'
                 sleep 5
                 docker exec -i ${s} /bin/sh -c '/usr/bin/galera_new_cluster'
                 docker exec -i ${s} /bin/sh -c 'systemctl start mariadb'
                 docker exec -i ${s} /bin/sh -c 'mysql < /mdb/scripts/cr_users.sql'
                 docker exec -i ${s} /bin/sh -c 'mysql < /mdb/scripts/ins_some.sql'
                 docker exec -i ${s} /bin/sh -c 'mysql < /mdb/Alldata/world.sql'
                 ${HOME}/scripts/strtTerm.osa "docker exec -it $s mysql"
        ;;
        mdbsrv2) echo "Configuring the second galera node ..."
                 docker exec -i ${s} cp ${TGT}/server.cnf.srv2 /etc/my.cnf.d/server.cnf
                 docker exec -i $s /bin/sh -c 'systemctl start mariadb'
                 sleep 5
                 ${HOME}/scripts/strtTerm.osa "docker exec -it $s mysql"
        ;;
        mdbsrv3) echo "Configuring the third galera node ..."
                 docker exec -i ${s} cp ${TGT}/server.cnf.srv3 /etc/my.cnf.d/server.cnf
                 docker exec -i $s /bin/sh -c 'systemctl start mariadb'
                 sleep 5
                 $HOME/scripts/strtTerm.osa "docker exec -it $s mysql"
        ;;
        mdbmxscl) docker exec -i mdbmxscl cp ${TGT}/maxscale.cnf /etc/maxscale.cnf
                  docker exec -i mdbmxscl cp ${TGT}/masking_rules.json /etc/masking_rules.json
                  sleep 5 
                  docker exec -i ${s} /bin/sh -c 'systemctl restart maxscale'
                  ${HOME}/scripts/strtTerm.osa "docker exec -it ${s} bash"
                  ${HOME}/scripts/strtTerm.osa "docker exec -it ${s}  watch -n 1 -d maxctrl list servers"
        ;;
      esac
    done
  
  cat ${SRC}/readme.guey
}
