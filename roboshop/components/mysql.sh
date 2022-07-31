#!/bin/bash


COMPONENT=mysql
USER="roboshop"
LOGFILE="/tmp/$COMPONENT.log"
REPO_URL="https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/$COMPONENT.repo"
SCHEMA_URL="https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
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

## to validate if the password is already changed to RoboShop@1
echo " show databases " | mysql -uroot -pRoboShop@1 &>> $LOGFILE

if [ $? -ne 0 ] ; then 
    echo -n "Changing the default $COMPONENT root password: "
    ## getting the tempray passwd and storing it in a variable 
    DEFAULT_PASS=$(sudo grep "temporary password" /var/log/mysqld.log | awk '{print $NF}')  
    ## command to set the default password and store it in a file output redirector
    echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('RoboShop@1');" > /tmp/rootpsswd_chng
    ##login and changing the default passwd 
    mysql --connect-expired-password -uroot -p$DEFAULT_PASS  < /tmp/rootpsswd_chng &>> $LOGFILE
    stat $?
fi

echo show plugins | mysql -uroot -pRoboShop@1 | grep validate_password &>> $LOGFILE
if [ $? -eq 0 ] ; then 
    echo -n "uninstall passwd validate plugin: "
    echo 'uninstall plugin validate_password;' > /tmp/pass_validate &>> $LOGFILE
    
    mysql --connect-expired-password -uroot -pRoboShop@1 < /tmp/pass_validate &>> $LOGFILE
    stat $?
fi

# echo -n "dwonlading the schema"
# curl -s -L -o /tmp/mysql.zip $SCHEMA_URL &>> $LOGFILE
# stat $?

# echo -n "Extracting the schema"
# cd /tmp
# unzip -o mysql.zip &>> $LOGFILE
# stat $?

# echo -n "injecting the schema"
# cd mysql-main && mysql -u root -pRoboShop@1 < shipping.sql &>> $LOGFILE
# stat $?
