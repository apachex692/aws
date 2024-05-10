#!/bin/bash
#
# Author: Sakthi Santhosh
# Created on: 04/11/2023
RELEASE_SERVER="2023.4.20240429"

# Update System
dnf upgrade --releasever="$RELEASE_SERVER" -y

# Code Deploy Agent Installation
/opt/codedeploy-agent/bin/codedeploy-agent stop
yum erase codedeploy-agent -y

wget \
  https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install
chmod +x ./install && ./install auto
rm -f ./install
