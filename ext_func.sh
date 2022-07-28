#!/bin/bash


ext_fun(){
    echo "This is an function called outside this file"
    file_name=$0
    echo "The name of the external file is $file_name"
}