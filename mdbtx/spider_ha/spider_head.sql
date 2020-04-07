CREATE DATABASE IF NOT EXISTS backend;
DROP TABLE IF EXISTS backend.sbtest;

CREATE USER 'sp_user'@'172.20.0.2';
CREATE USER 'spider'@'172.20.0.2';

GRANT ALL ON *.* TO 'sp_user'@'172.20.0.2' IDENTIFIED BY 'letmein';
GRANT ALL ON *.* TO 'spider'@'172.20.0.2' IDENTIFIED BY 'letmein';


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
