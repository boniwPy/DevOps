#!/bin/bash
sudo apt-get install ruby -y
sudo apt-get install wget -y
cd $HOME
wget https://aws-codedeploy-ap-southeast-1.s3.ap-southeast-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
service=codedeploy-agent
if pgrep -x "$service" >/dev/null  
then
	echo 'OK'
else
	echo 'Down'
	sudo service codedeploy-agent start
fi
