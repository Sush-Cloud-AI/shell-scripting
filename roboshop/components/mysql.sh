#!/bin/bash

set -e  # exits the code if a cammnad fails
COMPONENT=mysql
USER="roboshop"
LOGFILE="/tmp/$COMPONENT.log"
REPO_URL="https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/$COMPONENT.repo"

## sourcing the if loop to check if the user is root or not
source components/common.sh

echo -n "Configuring $COMPONENT Repo: "
curl -s -L -o /etc/yum.repos.d/mysql.repo $REPO_URL 
stat $?

echo -n "Installing $COMPONENT:  "
yum install mysql-community-server -y &>> $LOGFILE
stat $?

echo -n "Starting $COMPONENT: "
systemctl enable mysqld &>> $LOGFILE && systemctl start mysqld &>> $LOGFILE
stat $?
systemctl status mysqld -l

echo -n "Changing the default $COMPONENT root password: "
DEFAULT_PASS=$(sudo grep "temporary password" /var/log/mysqld.log | awk '{print $NF}')
echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('RoboShop@1');" > /tmp/rootpsswd_chng
mysql --connect-expired-password -uroot -p$DEFAULT_PASS < /tmp/rootpsswd_chng
stat $?