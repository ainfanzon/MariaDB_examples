# Spider Test with High Availability

## Step 1) Start the docker containers using the democtl script located in the MariaDB_examples folder.

In the installation directory execute the democtl script

./democtl -s mdbtx -d spider_ha -a [ start | stop ]


===============================================================================
2) LAYOUT SETUP: Open 2 windows for Maxscale and 3 for MariaDB servers.

+-----------------------+
|    spider head node   |
+-------+-------+-------+
| node1 | node2 | node3 |
+-------+-------+-------+

===============================================================================
3) Enable the Spider storage engine

Talking points
  + easy install. One step

COMMANDS
========

# On the spider server execute

 SHOW ENGINES;

 \! clear
 SOURCE /usr/share/mysql/install_spider.sql;
 SHOW ENGINES;

===============================================================================
4) Create server entries on spider server

COMMANDS
========
# ON HEAD NODE

 \! clear
 system cat /mdb/mdbtx/spider_ha/spider_head.sql

# ON ALL (HEAD AND NODE) SPIDER SERVERS

 \! clear
 SELECT Server_name, Host, Db, Port FROM mysql.servers\G

===============================================================================
5) Verify the spider user can connect from the head node to the backend nodes

COMMANDS
========
# On the HEAD NODE

 \! clear
 system  mysql -u sp_user -pletmein -h 172.20.0.2 -e 'SELECT @@hostname'
 system  mysql -u sp_user -pletmein -h 172.20.0.3 -e 'SELECT @@hostname'
 system  mysql -u sp_user -pletmein -h 172.20.0.4 -e 'SELECT @@hostname'
 system  mysql -u sp_user -pletmein -h 172.20.0.5 -e 'SELECT @@hostname'

===============================================================================
6) Check the backend tables were created

COMMANDS
========

# ON ALL SPIDER NODES

 \! clear
 SHOW TABLES FROM backend;
 SHOW TABLES FROM backend_rpl;
 SHOW CREATE TABLE sbtest\G

===============================================================================
7) Use case 1: Sharding without HA

COMMANDS
========

# ON THE SPIDER HEAD NODE: 

 \! clear
 system cat /mdb/mdbtx/spider_ha/cr_sharding_no_ha.sql

# SHOW THE CURRENT VALUES

 SOURCE /mdb/mdbtx/spider_ha/cr_sharding_no_ha.sql
 INSERT INTO backend.sbtest select 10000001, 0, '' ,'replicas test';

 SELECT * FROM sbtest WHERE id=10000001;

# ON ALL SPIDER NODES

 \! clear
 SELECT * FROM backend.sbtest;
 SELECT * FROM backend_rpl.sbtest;

# ON ANY SPIDER NODE: What is happening if we stop one backend?

 SHUTDOWN;

# ON THE SPIDER HEAD NODE

 \! clear
 SELECT * FROM sbtest WHERE id=10000001;

ERROR 1429 (HY000): Unable to connect to foreign data source: backend1_rpl

# EXECUTE NEXT COMMAND ON THE SERVER THAT IS DOWN
  
 \! systemctl start mariadb
 \! clear

===============================================================================
8) Use Case 2: Sharding with HA
Let's fix this with spider monitoring.

COMMANDS
========

# ON THE SPIDER HEAD NODE

 \! clear 
 \! cat /mdb/mdbtx/spider_ha/cr_sharding_ha.sql

 \! clear
 SOURCE /mdb/mdbtx/spider_ha/cr_sharding_ha.sql

# NOTE: THIS STEP SHOWS WHAT HAPPENDS WHEN STARTING MONITORING - NOT NEEDED IN PRODUCTION

 \! clear
 SELECT * FROM backend.sbtest WHERE id=10000001;
 SELECT spider_flush_table_mon_cache();

 SELECT db_name, table_name, server, link_status FROM mysql.spider_tables;

# EXECUTE NEXT COMMAND ON THE SERVER THAT IS DOWN
  
 \! systemctl start mariadb

# ON THE HEAD NODE

 \! clear
 \! cat /mdb/mdbtx/spider_ha/recover.sql

 SOURCE /mdb/mdbtx/spider_ha/recover.sql
 SELECT db_name, table_name, server, link_status FROM mysql.spider_tables;

 INSERT INTO backend.sbtest select 10000003, 0, '' ,'replicas test';

# ON THE SPIDER NODES

 \! clear
 SELECT * FROM backend.sbtest;
 SELECT * FROM backend_rpl.sbtest;

# ON ANY SPIDER NODE;

  SHUTDOWN;

 \! clear
 SELECT * FROM backend.sbtest;
 SELECT * FROM backend_rpl.sbtest;

# ON THE HEAD NODE

 SELECT * FROM backend.sbtest;

# ON THE NODE THAT IS DOWN

 \! systemctl start mariadb

===============================================================================
===============================================================================

ON THIS WINDOW 

 /Users/Shared/mdbtx/spider_ha/setup.sh

===============================================================================
===============================================================================
9) Use case 2: sharding by Range

COMMANDS
========

# ON THE SPIDER NODES:

 SHOW TABLES;

# ON THE SPIDER HEAD NODE:

 \! clear
 \! cat /mdb/mdbtx/spider_ha/cr_byRange.sql

 SOURCE /mdb/mdbtx/spider_ha/cr_byRange.sql
 \! /mdb/mdbtx/spider_ha/ld_opportunities.sh;

 SELECT * FROM backend.opportunities;

# ON EACH SPIDER NODE

 \! clear
 SELECT COUNT(*) FROM backend.opportunities;

 \! clear
 SELECT id, accountName, name, amount FROM backend.opportunities ORDER BY accountName;

===============================================================================
10) Use case 3: sharding by List

COMMANDS
========

# ON THE SPIDER HEAD NODE:

 \! clear
 \! /mdb/mdbtx/spider_ha/cleanup.sh
 \! cat /mdb/mdbtx/spider_ha/cr_byList.sql

 SOURCE /mdb/mdbtx/spider_ha/cr_byList.sql
 \! /mdb/mdbtx/spider_ha/ld_opportunities.sh;

 SELECT * FROM backend.opportunities;

# ON EACH SPIDER NODE

 \! clear
 SELECT COUNT(*) FROM backend.opportunities;

 \! clear
 SELECT id, owner, name, amount FROM backend.opportunities ORDER BY owner;

