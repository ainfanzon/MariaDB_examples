create server backend1 foreign data wrapper mysql options (
  host '172.20.0.3', database 'test', user 'sp_user', password 'letmein', port 3306
);
create server backend2 foreign data wrapper mysql options (
  host '172.20.0.4', database 'test', user 'sp_user', password 'letmein', port 3306
);
create server backend3 foreign data wrapper mysql options (
  host '172.20.0.5', database 'test', user 'sp_user', password 'letmein', port 3306
);
