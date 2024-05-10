#!/bin/bash
#
# Author: Sakthi Santhosh
# Created on: 10/05/2024
RELEASE_SERVER="2023.4.20240429"

# Update System
dnf upgrade --releasever="$RELEASE_SERVER" -y
yum install -y python3-pip tree wget yum-utils

# GitHub Credentials
aws s3 cp \
  s3://secrets-bucket-04112023/.ssh/sakthisanthosh010303_github.pub \
  /home/ec2-user/.ssh/
aws s3 cp \
  s3://secrets-bucket-04112023/.ssh/sakthisanthosh010303_github \
  /home/ec2-user/.ssh/

# AWS Credentials
mkdir /home/ec2-user/.aws/
aws s3 cp s3://secrets-bucket-04112023/.aws/config /home/ec2-user/.aws/
aws s3 cp s3://secrets-bucket-04112023/.aws/credentials /home/ec2-user/.aws/
