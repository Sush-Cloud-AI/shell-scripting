#!/bin/bash


# validating the root user

User_id=$(id -u) ## to validiate its as root user 

if [ $User_id -ne 0 ] ; then
    echo -e "\e[31m You need to run it as a root user \e[0m"
    exit 1
fi