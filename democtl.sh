#!/bin/zsh
#
# NAME
#
# 	democtl.sh - launch servers to test a MariaDB solution feature
#
# SYNOPSIS
#
#	democtl.sh -s <mdbtx | mdbax | maxscl> -d <feature> -a <start | stop | reset>
#
# DESCRIPTION
#
# This script launch an environment to test features of MariaDB solutions. All arguments are 
# mandatory
#
#	-s
#		Solution to test, either: mdbtx, mdbax or maxscl
#
#	-d	
#		Feature to test. See subdirectory names under the solution directory for
#		available features
#
#	-a
#		Action to perform either: start, stop or reset the environment
#
# AUTHOR
#
# 	Alejandro Infanzon
#
# TO DO
#
#
# REPORTING BUGS
#
#       alexinfanzon@yahoo.com
#       
#COPYRIGHT
#
#       This is free software: you are free to change and redistribute it.
#       There is NO WARRANTY, to the extent permitted by law.
#
#SEE ALSO    

###############################################################################
# Variables Initialization
###############################################################################
RED='\033[0;31m'
BLUE='\033[0;34M'
GREEN='\033[0;32M'
NC='\033[0:0M' # NO COLOR
TOPOLOGY_DIR=mdbDockerTopo
action=""
solution=""
demo=""

###############################################################################
# Function start docker containers
###############################################################################
StartDemo(){
  echo -e "OK I need to start the demo in: ${HOST_HOME_DIR}/${solution}/${demo}"
  echo -e "Starting containers for demo: ${demo}..."

  case ${solution} in
    maxscl) docker-compose -f ${HOST_HOME_DIR}/${TOPOLOGY_DIR}/mdb-docker-3-1.yml up -d
 	    ;;
     mdbx3) docker-compose -f ${HOST_HOME_DIR}/${TOPOLOGY_DIR}/mdb-docker-1-1-1.yml up -d
 	    ;;
     mdbtx) if [ "${demo}"  = 'spider' ]; then
              docker-compose -f ${HOST_HOME_DIR}/${TOPOLOGY_DIR}/mdb-docker-4-0.yml up -d
            else
              docker-compose -f ${HOST_HOME_DIR}/${TOPOLOGY_DIR}/mdb-docker-1-1.yml up -d
            fi
	    ;;
	 ?) echo -e "AICA"
	    exit 1
	    ;;
  esac

  sleep 5
  source ${HOST_HOME_DIR}/${solution}/${demo}/launch.sh
  launch_demo  ${HOST_HOME_DIR} ${solution} ${demo}
}

###############################################################################
# Function stop docker containers
###############################################################################
StopDemo(){
  echo -e "I need to stop the demo now!"

  while read -q "YN?Is that okay [y/n]?" && if [[ ${YN} =~ '[Yy]' ]] ; do
    echo "\n"
    case ${solution} in
       mdbtx) if [ "${demo}"  = 'spider' ]; then
                docker-compose -f ${HOST_HOME_DIR}/${TOPOLOGY_DIR}/mdb-docker-4-0.yml down
              else
                docker-compose -f ${HOST_HOME_DIR}/${TOPOLOGY_DIR}/mdb-docker-1-1.yml down
              fi
  	      ;;
       mdbx3) docker-compose -f ${HOST_HOME_DIR}/${TOPOLOGY_DIR}/mdb-docker-1-1-1.yml down
              ;;
      maxscl) 
              docker-compose -f ${HOST_HOME_DIR}/${TOPOLOGY_DIR}/mdb-docker-3-1.yml down
  	      ;;
	   ?) echo -e "AICA"
	      exit 1
	      ;;
    esac
    break 
  done

  echo y | docker system prune;
  echo y | docker volume prune;
  echo y | docker network prune;
  echo "Closing terminals\n"
  osascript -e 'tell application "iTerm" to quit'
  exit 0
}

###############################################################################
# Function reset docker containers
###############################################################################
demoStatus(){
  echo -e "Currently running!"
  docker ps -a
}

###############################################################################
# Function reset docker containers
###############################################################################
ResetDemo(){
  echo -e "OK I need to reset the demo now!"
}

###############################################################################
# Main Section
###############################################################################
while getopts 'a:s:d:t:' option; do
  case ${option} in
    a) action=${OPTARG}
       ;;
    s) solution=${OPTARG}
       ;;
    d) demo=${OPTARG}
       ;;
    t) topology=${OPTARG}
       ;;
    ?) echo -e "${RED}SCRIPT USAGE: $(basename $0) -a start|stop|reset -s <solution> -d <demo> -t <mdb topology>" >&2
      exit 1
      ;;
  esac
done

HOST_HOME_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo -e "Host home directory (HOST_HOME_DIR): $HOST_HOME_DIR"
CONTAINER_SRC_DIR=/mdb/$solution/$demo
echo -e "Container Source directory: $CONTAINER_SRC_DIR"

case "$action" in
  start) StartDemo
         ;;
   stop) StopDemo
         ;;
 status) demoStatus
         ;;
  reset) ResetDemo
	 ;;
      ?) echo -e "AICA: Unknown action in Main Section"
         exit 1 
         ;;
esac
