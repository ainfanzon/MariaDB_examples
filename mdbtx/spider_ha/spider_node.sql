CREATE USER 'sp_user'@'172.20.0.2';
CREATE USER 'spider'@'172.20.0.2';

CREATE DATABASE backend;
CREATE DATABASE backend_rpl;

GRANT ALL ON *.* TO 'sp_user'@'172.20.0.2' IDENTIFIED BY 'letmein';
GRANT ALL ON *.* TO 'spider'@'172.20.0.2' IDENTIFIED BY 'letmein';
FLUSH PRIVILEGES;

create server backend1 foreign data wrapper mysql options (
  host '172.20.0.3', database 'backend', user 'sp_user', password 'letmein', port 3306
);
create server backend2 foreign data wrapper mysql options (
  host '172.20.0.4', database 'backend', user 'sp_user', password 'letmein', port 3306
);
create server backend3 foreign data wrapper mysql options (
  host '172.20.0.5', database 'backend', user 'sp_user', password 'letmein', port 3306
);
create server backend1_rpl foreign data wrapper mysql options (
  host '172.20.0.3', database 'backend_rpl', user 'sp_user', password 'letmein', port 3306
);
create server backend2_rpl foreign data wrapper mysql options (
  host '172.20.0.4', database 'backend_rpl', user 'sp_user', password 'letmein', port 3306
);
create server backend3_rpl foreign data wrapper mysql options (
  host '172.20.0.5', database 'backend_rpl', user 'sp_user', password 'letmein', port 3306
);

DROP TABLE IF EXISTS backend_rpl.sbtest;
CREATE TABLE backend_rpl.sbtest
(
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  k int(10) unsigned NOT NULL DEFAULT '0',
  c char(120) NOT NULL DEFAULT '',
  pad char(60) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  KEY k (k)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS backend.sbtest;
CREATE TABLE backend.sbtest
(
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  k int(10) unsigned NOT NULL DEFAULT '0',
  c char(120) NOT NULL DEFAULT '',
  pad char(60) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  KEY k (k)
) ENGINE=InnoDB;

CREATE TABLE test.opportunities (
    id int
  , accountName varchar(50)
  , name varchar(128)
  , owner varchar(50)
  , amount decimal(10,2)
  , closeDate date
  , stageName varchar(50)
  , primary key (id)
  , key (accountName)
) engine=InnoDB;
