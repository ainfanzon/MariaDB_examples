DROP TABLE IF EXISTS backend.sbtest;
CREATE  TABLE backend.sbtest
(
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  k int(10) unsigned NOT NULL DEFAULT '0',
  c char(120) NOT NULL DEFAULT '',
  pad char(60) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  KEY k (k)
) ENGINE=spider COMMENT='wrapper "mysql", table "sbtest"'
 PARTITION BY KEY (id) 
(
   PARTITION pt1 COMMENT = 'srv "backend1 backend2_rpl", mbk "2", mkd "2", msi "1", link_status "0 0"'
 , PARTITION pt2 COMMENT = 'srv "backend2 backend3_rpl", mbk "2", mkd "2", msi "1", link_status "0 0"'
 , PARTITION pt3 COMMENT = 'srv "backend3 backend1_rpl", mbk "2", mkd "2", msi "1", link_status "0 0"'
) ;

CREATE SERVER mon
  FOREIGN DATA WRAPPER mysql 
OPTIONS( 
  HOST '172.20.0.2',
  DATABASE 'backend',
  USER 'sp_user',
  PASSWORD 'letmein',
  PORT 3306
);

INSERT INTO `mysql`.`spider_link_mon_servers` VALUES
('%','%','%',1,'mon',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL);
SELECT spider_flush_table_mon_cache();
