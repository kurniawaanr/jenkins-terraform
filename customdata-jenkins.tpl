#!/bin/bash

# Update package lists
sudo apt-get update -y

# Install Java
sudo apt-get install -y default-jre

# Install prerequisites for adding Jenkins repository
sudo apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common

# Add Jenkins GPG key
sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -

# Add Jenkins repository
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# Update package lists again
sudo apt-get update -y

# Install Jenkins
sudo apt-get install -y jenkins

systemctl enable jenkins
systemctl start Jenkins