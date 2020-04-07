  SRC=/mdb/mdbtx/spider_ha

  for s in {mdbsrv1,mdbsrv2,mdbsrv3,mdbsrv4};
  do
    case ${s} in
      mdbsrv1) echo "Configuring the spider node ..."
               #docker exec -i ${s} /bin/sh -c 'mysql < '${SRC}'/spider_head.sql'
      ;;
      mdbsrv2) echo "Configuring spider node 1 ..."
               docker exec -i ${s} /bin/sh -c 'mysql < '${SRC}'/cr_bkend_tab.sql'
      ;;
      mdbsrv3) echo "Configuring spider node 2 ..."
               docker exec -i ${s} /bin/sh -c 'mysql < '${SRC}'/cr_bkend_tab.sql'
      ;;
      mdbsrv4) echo "Configuring spider node 3 ..."
               docker exec -i ${s} /bin/sh -c 'mysql < '${SRC}'/cr_bkend_tab.sql'
      ;;
    esac
  done
