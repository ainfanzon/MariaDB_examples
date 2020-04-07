DROP TABLE IF EXISTS test.opportunities;
CREATE TABLE test.opportunities (
    id            int(11) NOT NULL
  , accountName   varchar(50) DEFAULT NULL
  , name          varchar(128) DEFAULT NULL
  , owner         varchar(50) DEFAULT NULL
  , amount        decimal(10,2) DEFAULT NULL
  , closeDate     date DEFAULT NULL
  , stageName     varchar(50) DEFAULT NULL
  , PRIMARY KEY (id)
  , KEY accountName (accountName)
) ENGINE=SPIDER DEFAULT CHARSET=latin1 COMMENT='wrapper "mysql", table "opportunities"'
PARTITION BY HASH (id) (
    PARTITION `pt1` COMMENT = 'srv "backend1", mbk "2", mkd "2", link_status "0 0"'
  , PARTITION `pt2` COMMENT = 'srv "backend2", mbk "2", mkd "2", link_status "0 0"'
  , PARTITION `pt3` COMMENT = 'srv "backend3",, mbk "2", mkd "2", link_status "0 0"'
);


DROP SERVER IF EXISTS mon;
CREATE SERVER mon
  FOREIGN DATA WRAPPER mysql 
OPTIONS( 
  HOST '172.20.0.2',
  DATABASE 'test',
  USER 'skysql',
  PASSWORD 'spider',
  PORT 3306
);

INSERT INTO `mysql`.`spider_link_mon_servers` VALUES
('%','%','%',1,'mon',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL);
SELECT spider_flush_table_mon_cache();
