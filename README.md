# MariaDB How to examples

## To Do List

- [ ] Add installation procedure in the installation section below.
- [ ] Test installation instructions are working.
- [ ] Set the scripts to use the install directory instead of the /mdb hardcoded one.
- [ ] How to download and install this project from Github?
- [ ] Create directory for Galera automatic failover example.
- [ ] Create directory for MaxScale Sharding example.
- [ ] Create directory for Spider example.
- [ ] Create directory for PL/SQL emulation in MariaDB example.
- [ ] Replace Apple Sripts with Python scripts for iTerm2

## Description

These is a collection of Docker environments to test MariaDB solutions and tools.

< $INSTALL_DIR > -+
                  +- docker_files
                  +- maxscl -+
                  |          +- failover
                  +- mdbax
                  +- mdbDockerTopo
                  +- mdbtx
                  +- scripts

## Getting Started 

These instructions will get you a copy of the project up and running on your local machine for development and testing. 
This project was built on a MacOS environment using Docker. It can run on Linux or Windows environments so long as you have
a Docker environment installed (some changes and addtional tool, e.g., cygwin on Windows, might need to be installed).

### Prerequisites

This project was originally created in the following environment. 

> macOS Catalina: 10.15.2<br>
> Docker Engine: 19.03.5<br>
> Docker Compose: 1.24.1<br>
> Docker Machine: 0.16.2<br>

Documentation on how to can be found in [Install Docker Desktop on Mac](https://docs.docker.com/docker-for-mac/install/)

Most of the commands are executed from the command-line. iTerm2 provides an easy to use interface on macOS. To download iTerm2 and instructions for installation steps go to: [iTerm2 Home page](https://www.iterm2.com/index.html)

Some Mac automation scripting code is used. See [About Mac Scripting](https://developer.apple.com/library/archive/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/index.html#//apple_ref/doc/uid/TP40016239-CH56-SW1) for in-depth details.

## Installation Process

1. Create a directory < $INSTALL_DIR>. Download the project and create the directory tree described above. 
   IMPORTANT: Make sure this directory is shared. This is required to access all the files from the container
2. Build the docker images - The README.md inside the docker_images explains how to create the docker images.
3. Execute the democtl zsh script to launch the solution you want to test. Make sure the script is executable. The syntax is
  
   $ ./democtl -s <solution> -d <feature to test> -a <action>
  
     -s <solution>.         Is the directory name that holds the solution. The available solutions are maxscl, mdbax or mdbtx
     -d <feature to test>.  Is the directory name that holds the test script. For example failover, etc.
     -a <action>.           Posible actions are start|stop|reset

