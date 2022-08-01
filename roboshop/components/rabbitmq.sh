#!/bin/bash

set -e  # exits the code if a cammnad fails
## sourcing the if loop to check if the user is root or not
source components/common.sh

COMPONENT=rabbitmq
LOGFILE="/tmp/$COMPONENT.log"
USER="roboshop"

echo -n "Configuring $COMPONENT repo: "
curl -s https://packagecloud.io/install/repositories/$COMPONENT/$COMPONENT-server/script.rpm.sh | sudo bash &>> $LOGFILE
stat $?

echo -n "Installing Erlang dependency: "
yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm rabbitmq-server -y &>> $LOGFILE
stat $?


echo -n "Starting  $COMPONENT service: "
systemctl enable rabbitmq-server &>> $LOGFILE
systemctl start rabbitmq-server &>> $LOGFILE
stat $?
systemctl status rabbitmq-server -l


