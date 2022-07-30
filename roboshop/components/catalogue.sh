#!/bin/bash

set -e  # exits the code if a cammnad fails
COMPONENT=catalogue
LOGFILE="/tmp/$COMPONENT.log"
REOP_URL="https://github.com/stans-robot-project/catalogue/archive/main.zip"


echo -n "Configuring nodejs Repo: "
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
stat $?

echo -n "Installing nodejs: "
yum install nodejs -y
stat $?

echo -n "Creating the roboshop user: "
useradd roboshop
stat $?

echo -n "Downloading the $COMPONENT Repo: "
curl -s -L -o /tmp/$COMPONENT.zip $REPO_URL
sata $?
#$ cd /home/roboshop
#$ unzip /tmp/$COMPONENT.zip
#$ mv $COMPONENT-main $COMPONENT
#$ cd /home/roboshop/$COMPONENT
#$ npm install

# Update MONGO_DNSNAME with MongoDB Server IP
# vim systemd.servce

# mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl start catalogue
# systemctl enable catalogue
# systemctl status catalogue -l


# vim /etc/nginx/default.d/roboshop.conf
# systemctl restart nginx