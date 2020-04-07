function launch_demo(){

echo "In launch_demo"
HOME=$1
echo "Home directory (HOME): ${HOME}"
SRC=/mdb/$2/$3
echo "Source directory (SRC): ${SRC}"

for s in {mdbsrv,pysrv};
  do
    case ${s} in
      mdbsrv) #if [ -d "$DATA/data_dir1" ]; then
               # rm -r $DATA/data_dir1
               # mkdir $DATA/data_dir1 && tar -zxf $DATA/data_dir.tar.gz -C $DATA/data_dir1
               # chown -R mysql:mysql $DATA/data_dir1
	       # chmod 755 $DATA/data_dir1
              #else
               # mkdir $DATA/data_dir1 && tar -zxf $DATA/data_dir.tar.gz -C $DATA/data_dir1
	        #chmod -R mysql:mysql $DATA/data_dir1
	        #chmod 755 $DATA/data_dir1
              #fi
	      echo -e "Copying the configuration file"
              #docker exec -i ${s} cp ${SRC}/server.cnf /etc/my.cnf.d/server.cnf
              docker exec -i ${s} /bin/sh -c 'systemctl restart mariadb'
              #${HOME}/script/strtTerm.osa "docker exec -it ${s} mysql -h mdbsrv -u mdb -pLetme1n-n0w"
              docker exec -it ${s} /bin/sh -c 'mysql < /mdb/scripts/cr_users.sql'
              docker exec -it ${s} /bin/sh -c 'mysql < /mdb/scripts/dbsample.sch'
              ${HOME}/scripts/strtTerm.osa "docker exec -it ${s} mysql"
      ;;
      pysrv) docker exec -i ${s} cp $SRC/mysqlslap /usr/bin
             ${HOME}/scripts/strtTerm.osa "docker exec -it ${s} bash"
      ;;
    esac
  done

  echo "Readme doc"
  cat ${HOME}/$2/$3/readme.guey
}
