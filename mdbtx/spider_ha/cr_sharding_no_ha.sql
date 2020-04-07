DROP TABLE IF EXISTS backend.sbtest;
CREATE  TABLE backend.sbtest
(
    id int(10) unsigned NOT NULL AUTO_INCREMENT
  , k int(10) unsigned NOT NULL DEFAULT '0'
  , c char(120) NOT NULL DEFAULT ''
  , pad char(60) NOT NULL DEFAULT ''
  , PRIMARY KEY (id)
  , KEY k (k)
) ENGINE=spider COMMENT='wrapper "mysql", table "sbtest"'
 PARTITION BY KEY (id) 
(
    PARTITION pt1 COMMENT = 'srv "backend1 backend2_rpl"'
  , PARTITION pt2 COMMENT = 'srv "backend2 backend3_rpl"' 
  , PARTITION pt3 COMMENT = 'srv "backend3 backend1_rpl"' 
) ;
