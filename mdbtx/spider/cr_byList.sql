DROP TABLE IF EXISTS test.opportunities;

CREATE TABLE test.opportunities (
    id            int(11) NOT NULL
  , accountName   varchar(50) DEFAULT NULL
  , name          varchar(128) DEFAULT NULL
  , owner         varchar(50) DEFAULT NULL
  , amount        decimal(10,2) DEFAULT NULL
  , closeDate     date DEFAULT NULL
  , stageName     varchar(50) DEFAULT NULL
  , PRIMARY KEY (id, owner)
  , KEY accountName (accountName)
) ENGINE=SPIDER DEFAULT CHARSET=latin1 COMMENT='wrapper "mysql", table "opportunities"'
PARTITION BY list columns (owner)
(
  PARTITION pt1 values in ('Michael Bolton','Brian Wilson','Lady Gaga') COMMENT = 'srv "backend1"',
  PARTITION pt2 values in ('Alanis Morissette','Buddy Holly','Linda Ronstadt') COMMENT = 'srv "backend2"',
  PARTITION pt3 values in ('Don Henley','Steven Tyler','Michael Jackson','Tina Turner') COMMENT = 'srv "backend3"'
);

TRUNCATE TABLE test.opportunities;
