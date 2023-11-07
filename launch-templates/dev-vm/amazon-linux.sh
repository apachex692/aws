#!/bin/bash
#
# Author: Sakthi Santhosh
# Created on: 04/11/2023
yum upgrade
yum install -y docker python3-pip tree wget yum-utils

aws s3 cp s3://secrets-bucket-04112023/.ssh/sakthisanthosh010303_github.pub /home/ec2-user/.ssh/
aws s3 cp s3://secrets-bucket-04112023/.ssh/sakthisanthosh010303_github /home/ec2-user/.ssh/

mkdir /home/ec2-user/.aws/
aws s3 cp s3://secrets-bucket-04112023/.aws/config /home/ec2-user/.aws/
aws s3 cp s3://secrets-bucket-04112023/.aws/credentials /home/ec2-user/.aws/

mkdir /var/log/nginx/sakthisanthosh.in/
mkdir /etc/nginx/ssl/

aws s3 cp s3://secrets-bucket-04112023/website-static-ssl/cert.pem /etc/nginx/ssl/
aws s3 cp s3://secrets-bucket-04112023/website-static-ssl/privkey.pem /etc/nginx/ssl/

/opt/codedeploy-agent/bin/codedeploy-agent stop
yum erase codedeploy-agent -y

wget https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install
chmod +x ./install && ./install auto
rm -f ./install

systemctl start nginx && systemctl enable nginx
eval "(ssh-agent -s)"

yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
yum -y install terraform
