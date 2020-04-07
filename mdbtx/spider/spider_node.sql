CREATE USER 'sp_user'@'172.20.0.2';
GRANT ALL ON test.* TO 'sp_user'@'172.20.0.2' IDENTIFIED BY 'letmein';
FLUSH PRIVILEGES;

CREATE USER 'spider'@'172.20.0.2';
GRANT ALL ON test.* TO 'spider'@'172.20.0.2' IDENTIFIED BY 'letmein';
FLUSH PRIVILEGES;

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
