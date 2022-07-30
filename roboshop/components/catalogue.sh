#!/bin/bash

set -e  # exits the code if a cammnad fails
COMPONENT=catalogue
USER="roboshop"
LOGFILE="/tmp/$COMPONENT.log"
REPO_URL="https://github.com/stans-robot-project/catalogue/archive/main.zip"

## sourcing the if loop to check if the user is root or not
source components/common.sh

echo -n "Configuring nodejs Repo: "
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> $LOGFILE
stat $?

echo -n "Installing nodejs: "
yum install nodejs -y &>> LOGFILE
stat $?

## creating user if it doesnot exists only if it doesnot exists 
echo -n "Creating the $USER user: "
id $USER &>> $LOGFILE || useradd $USER
stat $?


echo -n "Downloading the $COMPONENT Repo: "
curl -s -L -o /tmp/$COMPONENT.zip $REPO_URL &>> $LOGFILE
stat $?

## if the file exists ain re run it will trow an error 
echo -n "Performing cleanup: "
cd /home/$USER && rm -rf $COMPONENT
stat $?

echo -n "Extracting $COMPONENT : "
cd /home/roboshop
unzip -o /tmp/$COMPONENT.zip &>> $LOGFILE
mv $COMPONENT-main $COMPONENT && chown -R  $USER:$USER $COMPONENT    ### chown USER:GROUP FILE changing the ownership to robosho from root
cd /home/roboshop/$COMPONENT
stat $?

echo -n "Installing $COMPONENT: "
npm install &>> $LOGFILE
stat $?

### # Update MONGO_DNSNAME with MongoDB Server IP
echo -n "configuring the MONGO_DNSNAME "
sed -i -e 's/MONGO_DNSNAME/catalogue.robooutlet.internal' systemd.service
mv /home/roboshop/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service
stat $?

echo -n "Starting $COMPONENT seervice: "
systemctl daemon-reload
systemctl restart catalogue
systemctl enable catalogue
stat $?

systemctl status catalogue -l

echo -e "\e[32m _________________$COMPONENT configuration is completed________________\e[0m"
