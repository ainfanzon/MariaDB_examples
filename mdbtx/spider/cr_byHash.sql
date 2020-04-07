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
    PARTITION `pt1` COMMENT = 'srv "backend1"' ENGINE = SPIDER
  , PARTITION `pt2` COMMENT = 'srv "backend2"' ENGINE = SPIDER
  , PARTITION `pt3` COMMENT = 'srv "backend3"' ENGINE = SPIDER
);

TRUNCATE TABLE test.opportunities;
