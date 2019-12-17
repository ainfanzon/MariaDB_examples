# MariaDB MaxScale Master/Replicas Failover Example

## To Do List

- [ ] Add installation procedure in the installation section below.
- [ ] Test installation instructions are working.
- [ ] Set the scripts to use the install directory instead of the /mdb hardcoded one.

## Description

MariaDB MaxScale is an advanced database proxy. Failover for the master-replica cluster can be set to activate automatically. 
MaxScale monitors the database servers, so it will quickly notice any changes in server status or replication topology.

The script below demonstrates how automatic failover is configured and how it works.

## Getting Started 

These instructions will get you a copy of the project up and running on your local machine for development and testing. 
This project was built on a MacOS environment using Docker. It can run on Linux or Windows environments so long as you have
a Docker environment installed (some changes and addtional tool, e.g., cygwin, might need to be installed).

### Prerequisites

macOS Catalina: 10.15.2<br>
Docker Engine: 19.03.5<br>
Docker Compose: 1.24.1<br>
Docker Machine: 0.16.2<br>
Documentation on how to [Install Docker Desktop on Mac](https://docs.docker.com/docker-for-mac/install/)

Most of the commands are executed from the command-line. iTerm2 provides an easy to use interface on macOS. To download iTerm2 and instructions for installation steps go to: [iTerm2 Home page](https://www.iterm2.com/index.html)

Some Mac automation scripting code is used. See [About Mac Scripting](https://developer.apple.com/library/archive/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/index.html#//apple_ref/doc/uid/TP40016239-CH56-SW1) for in-depth details.

### Installation

Need to insert procedure here

### Executing the test

<ins>Start the test</ins>

The script creates two windows for MaxScale and three for MariaDB servers. One for the primary server (mdbsrv1) and two for the secondary servers(mdbsrv2, mdbsrv3).<br>
1) Place the MaxScale server window on the top left corner.
2) To the right a window executing the __watch__ command every second to display the output of the MaxScale list servers command.
3) At the bottom place all three database servers. On the bottom left the master server and the other two on the right are asynchronous replicas. All three servers are executing the mysql command line sql interface.

| maxscl | watch -n 1 |
| ------ | ---------- |

| mdbsrv1 | mdbsrv2 | mdbsrv3 |
| ------- | ------- | --------|

__COMMANDS:__

Execute the following commands on the host computer operating system shell. DEMO_HOME is the directory where the this example was installed.

\% cd DEMO_HOME<br>
\% democtl.sh -s maxscl -d failover -a start 

<ins>Test Replication</ins>

To test replication is working properly. On the __master__ node create a database to validate replication is working. The screen executing the watch command shows all the servers are synchronized. 

__COMMANDS:__

On all the database servers, execute the following commands on the mysql client tool. First check the IP address of the container. Then check the __trashme__ database does NOT exist. Create the __trashme__ database and validate it was created in all the replicas.

\> system hostname -I<br>
\> SHOW DATABASES;<br>
Execute this command in the master __ONLY__:<br>
> \> CREATE DATABASE trashme;

\> SHOW DATABASES;

Replication is working properly if the __trashme__ database was created in all the replicas.

<ins>Review MaxScale Configuration</ins>

Review the configuration settings in the MaxScale configuration file (maxscale.cnf). In the server section, check server IP addresses, review the database monitor, service definition and listeners sections. Then restart MaxScale.

__COMMANDS:__

\$ cat /etc/maxscale.cnf<br>      
\$ systemctl restart maxscale<br>
\$ maxctrl list services<br>
 
<ins>Test Automatic Failover</ins>

On the MaxScale server perform the following steps:

* In the window running the watch command, identify the primary server.
* Identify the master server name and IP address.
* Review the __loop.sh__ script.
>> The first attribute in the select statement indicates where the read came from.
>> NOTE: Due to the asynchronous replication an insert might not have been replicated, thus the not found message would be displayed in red.
* Validate the IP address in the script matches the IP address of the MaxScale server (maxscl)

__COMMANDS:__

$ clear ; cat /mdb/maxscl/failover/loop.sh
$ hostname -I
$ /mdb/maxscl/failover/loop.sh

> Execute the following command on primary MariaDB server
 
$ SHUTDOWN;

> Restart server
 
\> system systemctl start mariadb

<ins> Test Causal Consistency and Transaction Replay

Edit the MaxScale configuration file and uncomment __causal_reads__ and __transaction_replay__. Restart MaxScale for the
changes to take effect.

Identify the new master and re-execute the script to see how the application continues to work even though the master 
server is down.

__COMMANDS:__

> Execute the following commands on the MaxScale server

$ vi /etc/maxscale.cnf<br>
$ systemctl restart maxscale<br>
$ clear ; /mdb/maxscl/failover/loop.sh<br>

> Shutdown the master database server<br>
\> SHUTDOWN;
