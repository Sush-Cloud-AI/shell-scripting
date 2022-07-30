#!/bin/bash

set -e  # exits the code if a cammnad fails
COMPONENT=frontend
LOGFILE="/tmp/$COMPONENT.log"

## sourcing the if loop to check if the user is root or not
source components/common.sh



echo -n "Installing nginx: "
yum install nginx -y &>> $LOGFILE
stat $? ### stat function in comman folder 

systemctl enable nginx &>> $LOGFILE

echo -n "Starting ngnix"
systemctl start nginx
stat $?

echo -n "Downloading $COMPONENT repo: "
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip" &>> $LOGFILE
stat $?

echo -n "Clearing the old content: "
cd /usr/share/nginx/html
rm -rf *
stat $?

echo -n "extracting the downloaded repo: "
unzip /tmp/frontend.zip &>> $LOGFILE
stat $?

echo -n "Updating the PROXY file: "
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?


echo -e "\e[32m _________________$COMPONENT configuration is completed________________\e[0m"