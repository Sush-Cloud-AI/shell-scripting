#!/bin/bash

COMPONENT=$1

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=devops-conf" | jq '.Images[].ImageId' | sed -e 's/"//g')

aws ec2 run-instances --image-id $AMI_ID --instance-type t2.micro --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT}]"
