ALTER TABLE backend.sbtest
ENGINE=spider COMMENT='wrapper "mysql", table "sbtest"'
 PARTITION BY KEY (id)
(
   PARTITION pt1 COMMENT = 'srv "backend1 backend2_rpl", mbk "2", mkd "2", msi "1", link_status "0 1"'
 , PARTITION pt2 COMMENT = 'srv "backend2 backend3_rpl", mbk "2", mkd "2", msi "1", link_status "1 0"'
 , PARTITION pt3 COMMENT = 'srv "backend3 backend1_rpl", mbk "2", mkd "2", msi "1", link_status "0 0"'
) ;

SELECT spider_flush_table_mon_cache();
