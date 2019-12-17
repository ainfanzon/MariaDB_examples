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



