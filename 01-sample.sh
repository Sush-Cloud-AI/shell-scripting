#!/bin/bash

echo "Hello world"

## Printing mutliple line 

echo "Hello"
echo "HI"

## \n : New line  : \t : Tab

echo -e "Hello\n\tmonkey"

#colour fore ground

echo -e "\e[31mI am Red\e[0m"
echo -e "\e[32mI am Green\e[0m"
echo -e "\e[33mI am yellow\e[0m"
echo -e "\e[34mI am Blue\e[0m"
echo -e "\e[35mI am Maganta\e[0m"

# forefround clour
echo -e "\e[45;33mI am yellow\e[0m"

# varaiables
# local variables
a=10
b=abc

# when to use quotes --- when input has special character 

echo $a
echo $b
echo ${b}   # same as $b

# undefined value 

echo "THis is a undefined variable $c"

# declaring value in command line are environment variables 

echo " The value of D is $d"

# always local(inside script) var >> env variabl(command line)


## dynamic output

date_command=$(date +%F)
echo "Todays date id $date_command"
echo "The number of users signed in are $(who | wc -l)"


### special variables

# $0  : This will print the script name that you are runing
# $?  : Will show the status code of the last execution if 0 sucess any thing ellse is fail
# $0 to $n , $*, $@, $#, $$

echo "script we are exeuting is $0"

# # Through command line we can pass upto 9 variables

echo "The value of x is $1"
echo "The name of the user is $2"

# sh script.sh 10 20 30     # pass values 
#              $1 $2 $3


## will print all the declared cli varibales $* 
echo "clli varaibles used are $*"

# will print the count of the cli variables
echo " the number of cli variables are $#"


# input from user

read -p 'Enter your name: ' NAME
echo -e "Name = $NAME"

## function

first_fun(){
    echo "This is the fist line of the function"
    echo "Today date is $(date +%F)"
    echo "This the end of the function"
}
# calling the function
first_fun
sleep 3
first_fun


# calling a function inside function
nest_func(){
    echo "this is nest_function"
    first_fun

}

nest_func

## stat function

stat(){
    echo "The average load from 15 minutes is $(uptime  | awk -F : '{print $NF}' | awk -F , '{print $3}')"
    echo " the number of connected users are $(who | wc -l) "
}