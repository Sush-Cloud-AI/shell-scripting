#!/bin/bash

set -e  # exits the code if a cammnad fails
COMPONENT=catalogue
USER="roboshop"
LOGFILE="/tmp/$COMPONENT.log"
#REPO_URL="https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"

## sourcing the if loop to check if the user is root or not
source components/common.sh


## calling nodejs fuction to install 
NODEJS


## calling create user function
CREATE_USER

## calling downlaod, clean and extract function
DOWNLOAD_EXTRACT

## calling npm install function
NPM_INSTALL

### calling the configuring service
CONFIG_SERVICE

## calling the start service function
STARTING_SERV

echo -e "\e[32m _________________$COMPONENT configuration is completed________________\e[0m"
