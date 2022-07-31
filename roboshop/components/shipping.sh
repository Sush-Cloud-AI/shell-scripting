#!/bin/bash

set -e  # exits the code if a cammnad fails
## sourcing the if loop to check if the user is root or not
source components/common.sh
COMPONENT=shipping
LOGFILE="/tmp/$COMPONENT.log"
USER="roboshop"

## calling maven install function
MAVEN

## calling create user roboshop function
CREATE_USER

## calling download and unzipp function
DOWNLOAD_EXTRACT

## calling shipping install function 
MVN_INSTALL

# ### configuring service ips/dns records function
# CONFIG_SERVICE

# ### calling start service 
# STARTING_SERV