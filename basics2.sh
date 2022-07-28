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

a=10
echo $a
echo "${a}"
echo ${a}
echo '$a'    

########## conditions

## case exampele 1

read input_srting

case $input_srting in
    hello)
        echo "hello sam"
        ;;
    bye)
        echo "bye see you again"
        ;;
    *)
        echo "I dont understand type hello or bye"
esac

## case examples 2

Action = $1


case $Action in
    start)
        echo "sevice starting"
        ;;
    bye)
        echo "service stopping"
        ;;
    *)
        echo -e "\e[33m should be either stop or start \e[0m"
esac

