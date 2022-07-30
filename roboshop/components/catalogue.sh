#!/bin/bash

set -e  # exits the code if a cammnad fails
COMPONENT=catalogue
USER="roboshop"
LOGFILE="/tmp/$COMPONENT.log"
REOP_URL="https://github.com/stans-robot-project/catalogue/archive/main.zip"

## sourcing the if loop to check if the user is root or not
source components/common.sh

echo -n "Configuring nodejs Repo: "
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> LOGFILE
stat $?

echo -n "Installing nodejs: "
yum install nodejs -y &>> LOGFILE
stat $?

echo -n "Creating the $USER user: "
useradd $USER
stat $?

sudo su - $USER

echo -n "Downloading the $COMPONENT Repo: "
curl -s -L -o /tmp/$COMPONENT.zip $REPO_URL &>> LOGFILE
sata $?


# cd /home/roboshop
# unzip -o /tmp/$COMPONENT.zip
# mv $COMPONENT-main $COMPONENT
# cd /home/roboshop/$COMPONENT
# npm install

# Update MONGO_DNSNAME with MongoDB Server IP
# vim systemd.servce

# mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl start catalogue
# systemctl enable catalogue
# systemctl status catalogue -l


# vim /etc/nginx/default.d/roboshop.conf
# systemctl restart nginx