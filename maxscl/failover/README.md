# MariaDB MaxScale Master/Replicas Failover Example

MariaDB __MaxScale__ is an advanced database proxy for MariaDB database servers. Failover for the master-replica cluster can
be set to activate automatically. MaxScale monitors the database servers, so it will quickly notice any changes in server
status or replication topology.

## Getting Started 

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.
This project was built on a MacOS environment using Docker. I will run on Linux or Windows environment so long as you have
a Docker environment installed.

### Prerequisites

<ins>macOS</ins>

macOS Catalina: 10.15.2

<ins>Docker</ins>

Docker Engine: 19.03.5<br>
Docker Compose: 1.24.1<br>
Machine: 0.16.2<br>
[Install Docker Desktop on Mac](https://docs.docker.com/docker-for-mac/install/)

<ins>iTerm2</ins>

Since you are going to be spending a lot of time in the command-line, I recommend to use iTerm2 rather than the default in macOS.

To download and install iTerm2 go to: [iTerm2 Home page](https://www.iterm2.com/index.html)

<ins>Mac Scripting</ins>

Some Mac Automation Scripting code is used. See [About Mac Scripting](https://developer.apple.com/library/archive/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/index.html#//apple_ref/doc/uid/TP40016239-CH56-SW1) for in-depth details.

### Installing 

TBD: need procedure here

### Executing the test

<ins>Start the test</ins>

2 windows for Maxscale and 3 for MariaDB servers. Primary server (mdbsrv1) and 2 secondary servers (mdbsrv2, mdbsrv3).

+---------+----------+<br>
|maxscl   |watch -n 1|<br>
+---------+----------+<br>
+--------+--------+--------+<br>
|mdbsrv1|mdbsrv2|mdbsrv3|<br>
+--------+--------+--------+<br>

1) On the top left corner, the MaxScale server
2) To the right a window executing the __watch__ command every second to display the output of the MaxScale list servers command
3) At the bottom we have three database servers. On the bottom left the master server and the other two on the right are asynchronous replicas. All three servers are executing the command line sql interface.


COMMANDS:

cd <DEMO_HOME>
democtl.sh -s maxscl -d failover -a start 


First step is to test replication is working properly. To do that let’s show all the databases in this installation.
ON THE MASTER NODE
2) SHOW REPLICATION IS WORKING

TALKING POINTS:
+ Correlate IPs to list servers output
+ All servers have the same schemas.
+ create a database to validate the synchronous replication is working
+ The watch command shows the all the servers are in Synch.

COMMANDS:

 system hostname -I
 SHOW DATABASES;
 CREATE DATABASE trashme;
 SHOW DATABASES;
===============================================================================
ON THE MAXSCALE SERVER
3) MAXSCALE CONFIGURATION AND ADMINISTRATION COMMANDS

TALKING POINTS:

+ Review the configurations settings in the MaxScale 
  Config file highlights: servers; Monitor; Service Def; listeners
top screen restart maxscale
+ Show active services

COMMANDS:
 cat /etc/maxscale.cnf           
 systemctl restart maxscale
 maxctrl list services
===============================================================================
4) CLIENT APP:

TALKING POINTS:
  + Identify the primary server and maxscale server IP addresis
  + read-write-split - first field indicates where the read came from; 
  + Due to async replication an insert might not have been replicated thus the not found message
  + secondary server is promoted to Master
  + the connection fails and cannot recover
  + server is now a secondary
  + it is now at the same GTID

Script explanation

COMMANDS:
 clear ; cat /mdb/maxscl/failover/loop.sh
 hostname -I
 /mdb/maxscl/failover/loop.sh

# On the MariaDB Primary server
 SHUTDOWN;

# Restart server
 system systemctl start mariadb
===============================================================================
6) CAUSAL CONSISTENCY AND TRANSACTION REPLAY

TALKING POINTS:
Uncomment causal_reads and transaction_replay

COMMANDS:
 vi /etc/maxscale.cnf
 systemctl restart maxscale

# Identify the new master and re-execute the loop script

 clear ; /mdb/maxscl/failover/loop.sh
 SHUTDOWN;
===============================================================================