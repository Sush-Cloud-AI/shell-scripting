#!/bin/bash

set -e  # exits the code if a cammnad fails
## sourcing the if loop to check if the user is root or not
source components/common.sh
COMPONENT=mongodb
LOGFILE="/tmp/COMPONENT.log"
REPO_URL="https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo"


echo -n "Downloading $COMPONENT repo : "
curl -s -o /etc/yum.repos.d/mongodb.repo $REPO_URL &>> $LOGFILE
stat $?

echo -n "Installing $COMPONENT : "
yum install -y mongodb-org &>> $LOGFILE
stat $?



echo -n "Starting $COMPONENT : "
systemctl enable mongod &>> $LOGFILE
systemctl start mongod &>> $LOGFILE
stat $?

# Config file:   # vim /etc/mongod.conf

# systemctl restart mongod
# curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"

# cd /tmp
# unzip mongodb.zip
# cd mongodb-main
# mongo < catalogue.js
# mongo < users.js
