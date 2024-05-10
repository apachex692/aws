#!/bin/bash
#
# Author: Sakthi Santhosh
# Created on: 04/11/2023
RELEASE_SERVER="2023.4.20240429"

# Update System
dnf upgrade --releasever="$RELEASE_SERVER" -y
yum install -y docker python3-pip tree wget yum-utils

# Install Terraform
yum-config-manager \
  --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
yum install -y terraform
