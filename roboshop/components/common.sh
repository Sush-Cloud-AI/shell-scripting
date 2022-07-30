#!/bin/bash


# validating the root user

User_id=$(id -u) ## to validiate its as root user 

if [ $User_id -ne 0 ] ; then
    echo -e "\e[31m You need to run it as a root user \e[0m"
    exit 1
fi

## fuction to check if the execution of command is sucessfull
stat(){
    if [ $1 -eq 0 ] ; then
    echo -e "\e[32m SUCCESS \e[0m"
else
    echo -e "\e[31m FAILURE \e[0m"
fi
}
