CREATE TABLE backend.opportunities (
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
