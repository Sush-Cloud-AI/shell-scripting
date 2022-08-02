#!/bin/bash

COMPONENT=$1
SG_ID="sg-04b01b7734f241f98"

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=devops-conf" | jq '.Images[].ImageId' | sed -e 's/"//g')


## aws ec2 run-instances --security-group-ids $SG_ID  --image-id $AMI_ID --instance-type t2.micro --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT}]" | jq

PRIVATE_IP=$(aws ec2 run-instances --security-group-ids $SG_ID  --image-id $AMI_ID --instance-type t2.micro --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g' )

#echo $PRIVATE_IP

sed -e "s/COMPONENT/$COMPONENT/" "s/PRIVATE_IP/$PRIVATE_IP/" > /tmp/record.json
aws route53 change-resource-record-sets --hosted-zone-id Z000835337LZTTXF3GS8F --change-batch file:///tmp/record.json | jq