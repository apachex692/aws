#!/bin/bash
#
# Author: Sakthi Santhosh
# Created on: 04/10/2023
export DEBIAN_FRONTEND=noninteractive

apt-get update && sudo apt-get upgrade -y
apt-get install -y cmatrix git python3 python3-pip python3-virtualenv tree

aws s3 cp s3://secrets-bucket-04102023/ssh/sakthisanthosh010303_github /home/admin/.ssh/
aws s3 cp s3://secrets-bucket-04102023/ssh/sakthisanthosh010303_github.pub /home/admin/.ssh/

chmod 600 /home/admin/sakthisanthosh010303_github && chmod 644 /home/admin/.ssh/sakthisanthosh010303_github.pub
chown admin:admin /home/admin/.ssh/*

eval "$(ssh-agent -s)"
ssh-add /home/admin/.ssh/sakthisanthosh010303_github

apt-get install -y ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings
curl -f -s -S -L https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
usermod -a -G docker admin
