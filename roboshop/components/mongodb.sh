#!/bin/bash

set -e  # exits the code if a cammnad fails
## sourcing the if loop to check if the user is root or not
source components/common.sh
COMPONENT=mongodb
LOGFILE="/tmp/$COMPONENT.log"
REPO_URL="https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo"
SCHEMA_URL="https://github.com/stans-robot-project/mongodb/archive/main.zip"

echo -n "Downloading $COMPONENT repo : "
curl -s -o /etc/yum.repos.d/mongodb.repo $REPO_URL &>> $LOGFILE
stat $?

echo -n "Installing $COMPONENT : "
yum install -y mongodb-org &>> $LOGFILE
stat $?



## Config file:   # vim /etc/mongod.conf
echo -n "Updating $COMPONENT Listining Address: "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

echo -n "Starting $COMPONENT : "
systemctl enable mongod &>> $LOGFILE
systemctl restart mongod &>> $LOGFILE
stat $?

echo -n "Downloading $COMPONENT schema: "
curl -s -L -o /tmp/mongodb.zip $SCHEMA_URL &>> $LOGFILE
stat $?

cd /tmp

### we need to give unzip  -o to overide the prompt that it will give to unzip the seccond time 
####when we re run the code 
echo -n "Extracting the $COMPONENT schemma: "
unzip -o mongodb.zip &>> $LOGFILE
stat $?

cd mongodb-main

echo -n "Injecting the $COMPONENT schemma: "
mongo < catalogue.js &>> $LOGFILE
mongo < users.js &>> $LOGFILE
stat $?

systemctl status mongod -l

echo -e "\e[32m _________________$COMPONENT configuration is completed________________\e[0m"