#!/bin/bash
set -e

yum update -y
yum install -y docker
systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user

docker run -d -p 80:8080 --name app eduardoneto01/deploy-terraform:latest
