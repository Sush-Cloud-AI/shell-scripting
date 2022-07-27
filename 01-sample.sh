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