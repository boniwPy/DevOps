#!/bin/bash
sudo apt-get install ruby
sudo apt-get install wget
cd $HOME
wget https://aws-codedeploy-ap-southeast-1.s3.region-identifier.amazonaws.com/latest/install
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
