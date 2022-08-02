#!/bin/bash

set -e  # exits the code if a cammnad fails
COMPONENT=payment
USER="roboshop"
LOGFILE="/tmp/$COMPONENT.log"


## sourcing the if loop to check if the user is root or not
source components/common.sh

## calling function to install python
PYTHON_INST

## calling function to creat user roboshop 
CREATE_USER

## calling function to download repo
DOWNLOAD_EXTRACT

###installing payment component
PAYMENT_INST


## need to add 
echo  "Updating $USER user id and group id in payment.ini file: "
UID_ROBO=$(id -u $USER)
GID_ROBO=$(id -g $USER)

sed -i -e "/uid/ c uid = $UID_ROBO" -e "/gid/ c gid = $GID_ROBO" payment.ini
stat $?


## calling function to update systemd service file with ip address
CONFIG_SERVICE

# calling start service function
STARTING_SERV