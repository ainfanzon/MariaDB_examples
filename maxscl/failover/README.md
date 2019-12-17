# MariaDB MaxScale Master/Replicas Failover Example

MariaDB __MaxScale__ is an advanced database proxy for MariaDB database servers. Failover for the master-replica cluster can
be set to activate automatically. MaxScale monitors the database servers, so it will quickly notice any changes in server
status or replication topology.

## Getting Started 

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.
This project was built on a MacOS environment using Docker. I will run on Linux or Windows environment so long as you have
a Docker environment installed.

### Prerequisites

macOS Catalina: 10.15.2<br>
Docker Engine: 19.03.5<br>
Docker Compose: 1.24.1<br>
Docker Machine: 0.16.2<br>
Documentation on how to [Install Docker Desktop on Mac](https://docs.docker.com/docker-for-mac/install/)

Most of the commands are executed from the command-line. iTerm2 provides an easy to use interface on macOS. To download iTerm 2 and get the installation steps go to: [iTerm2 Home page](https://www.iterm2.com/index.html)

Some Mac Automation Scripting code is used. See [About Mac Scripting](https://developer.apple.com/library/archive/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/index.html#//apple_ref/doc/uid/TP40016239-CH56-SW1) for in-depth details.

### Installing 

TBD: need procedure here

### Executing the test

<ins>Start the test</ins>

2 windows for Maxscale and 3 for MariaDB servers. Primary server (mdbsrv1) and 2 secondary servers (mdbsrv2, mdbsrv3).

|---------|----------|
|maxscl   |watch -n 1|
|---------|----------|
+--------+--------+--------+<br>
|mdbsrv1|mdbsrv2|mdbsrv3|<br>
+--------+--------+--------+<br>

1) On the top left corner, the MaxScale server
2) To the right a window executing the __watch__ command every second to display the output of the MaxScale list servers command
3) At the bottom we have three database servers. On the bottom left the master server and the other two on the right are asynchronous replicas. All three servers are executing the command line sql interface.


COMMANDS:

Execute the following commands on the host computer shell

cd DEMO_HOME<br>
democtl.sh -s maxscl -d failover -a start 

<ins>Test Replication</ins>

To test replication is working properly. On the __master__ node create a database to validate the synchronous replication is working. The screen executing the watch command shows all the servers are synchronized. 

COMMANDS:

Execute the following commands on the mysql client tool.

system hostname -I<br>
SHOW DATABASES;<br>
CREATE DATABASE trashme;<br>
SHOW DATABASES;<br>

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
