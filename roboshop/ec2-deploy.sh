#!/bin/bash

COMPONENT=$1
SG_ID="sg-04b01b7734f241f98"

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=devops-conf" | jq '.Images[].ImageId' | sed -e 's/"//g')

aws ec2 run-instances --security-group-ids $SG_ID  --image-id $AMI_ID --instance-type t2.micro --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT}]" | jq
