#!/bin/bash

### input output redirectors

### > file name standard output (sucess )
#### >> append the output (sucess)

### 2> standard error 
### 2>> append

### $>> both erro and sucess in one file 


### exit code


# echo hi

# exit 0   # run $?

# echo welcome back

## changing the exit code 

# echo hi

# exit 1    #  run $?

# echo welcome back

### changing the power of variables using quotes 

# a=10
# echo $a
# echo "${a}"
# echo ${a}
# echo '$a'    

########## conditions

# ## case exampele 1

# read input_srting

# case $input_srting in
#     hello)
#         echo "hello sam"
#         ;;
#     bye)
#         echo "bye see you again"
#         ;;
#     *)
#         echo "I dont understand type hello or bye"
# esac

## case examples 2

# Action=$1


# case $Action in
#     start)
#         echo "sevice starting"
#         exit 0
#         ;;
#     stop)
#         echo "service stopping"
#         exit 0
#         ;;
#     *)
#         echo -e "\e[33mShould be either stop or start \e[0m"
#         exit 1
#         ;;
# esac

#### Mutli line comment

# <<COMMENT
# echo "This a multi line comment"

# a=2
# echo $a
# COMMENT

#### if condtion

Par=$1


# ## simple if
# if [ "$Par" = "start" ] ; then
#     echo -e "Selected option is \e[32m start \e[0m"
# fi

### ifelse

# if [ "$Par" = "start" ] ; then
#     echo -e "Selected option is \e[32m start \e[0m"
# else
#     echo -e "Choose a valid option"
# fi

### elif 

# if [ "$Par" = "start" ] ; then
#     echo -e "Selected option is \e[31m start \e[0m"
# elif [ "$Par" = "stop" ] ; then
#     echo -e "Selected option is \e[32m stop \e[0m"
# elif [ "$Par" = "re-start" ] ; then
#     echo -e "Selected option is \e[33m restart \e[0m"
# else
#     echo -e "Choose a valid option"
#     exit 8
# fi

### logical opertors
 ###refer notes


 ### return 
 first_fun(){
    echo "This is the fist line of the function"
    echo "Today date is $(date +%F)"
    return                           ### will skip the rest of the function
    echo "This the end of the function"
}

stat(){
    echo "The average load from 15 minutes is $(uptime  | awk -F : '{print $NF}' | awk -F , '{print $3}')"
    echo " the number of connected users are $(who | wc -l) "
}

first_fun
stat

######## logical AND & Logical OR

### command1 && command2
###command 2 will be executed if command1 is suscessfull

##command1 || command2
##command2 will execute only if command1 is failure 

echo "hai" && echo "hello"

lsblkf && echo "will not execute because its an AND"

lsblkfd || echo "this will execute because it a OP"