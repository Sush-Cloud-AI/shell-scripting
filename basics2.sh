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

if ["$Par"="start"] ; then
    echo -e "Selected option is \e[32m start \e[0m"
fi




