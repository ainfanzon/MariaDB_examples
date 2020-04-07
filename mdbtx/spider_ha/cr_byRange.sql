DROP TABLE IF EXISTS backend.opportunities;

CREATE TABLE backend.opportunities (
    id            int(11) NOT NULL
  , accountName   varchar(50) DEFAULT NULL
  , name          varchar(128) DEFAULT NULL
  , owner         varchar(50) DEFAULT NULL
  , amount        decimal(10,2) DEFAULT NULL
  , closeDate     date DEFAULT NULL
  , stageName     varchar(50) DEFAULT NULL
  , PRIMARY KEY (id, accountName)
  , KEY accountName (accountName)
) ENGINE=SPIDER DEFAULT CHARSET=latin1 COMMENT='wrapper "mysql", table "opportunities"'
PARTITION BY range columns (accountName)
(
  PARTITION pt1 values less than ('H') COMMENT = 'srv "backend1"',
  PARTITION pt2 values less than ('P') COMMENT = 'srv "backend2"',
  PARTITION pt3 values less than (maxvalue) COMMENT = 'srv "backend3"'
);

TRUNCATE TABLE backend.opportunities;
