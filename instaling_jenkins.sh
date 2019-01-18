#!/bin/bash
#instaling jenkins with just 1 click or more ^_*
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt update
sudo apt install oracle-java8-installer -y
sudo apt install oracle-java8-set-default -y
javac -version
cd /tmp && wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add - 
echo 'deb https://pkg.jenkins.io/debian-stable binary/' | sudo tee -a /etc/apt/sources.list.d/jenkins.list 
sudo apt update 
sudo apt install jenkins -y
ipServer = `curl icanhazip.com`
echo "Bye Thanks, You Can Access Jenkins using $ipServer:8080"
