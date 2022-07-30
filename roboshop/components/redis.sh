#!/bin/bash
source components/common.sh
set -e  # exits the code if a cammnad fails
COMPONENT=redis
USER="roboshop"
LOGFILE="/tmp/$COMPONENT.log"

echo -n "Configuring the $COMPONENT repo: "
curl -L https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/$COMPONENT.repo -o /etc/yum.repos.d/$COMPONENT.repo &>> $LOGFILE
stat $?

echo -n "installing $COMPONENT: "
yum install redis-6.2.7 -y &>> $LOGFILE
stat $?

echo -n "Updating the $COMPONENT listening address "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf
stat $?

## calling start service 
STARTING_SERV

echo -e "\e[32m _________________$COMPONENT configuration is completed________________\e[0m"