#!/bin/bash
echo -e "#==============================================================# "
echo -e  "# Name:         Script for instaling php5.6-fpm               #"
echo -e  "# Description:  Install php5.6-fpm fast-cgi at ec2 instance   #"
echo -e  "# Version:      V.Karya Anak Bangsa.1.1                       #"
echo -e  "# Author     :  DevOps@payrightsystem.com                     #"
echo -e  "# License:      GNU General Public License, version 3 (GPLv3) #"
echo -e  "# License URI:  http://www.gnu.org/licenses/gpl-3.0.html      #"
echo -e  "#=============================================================#"

echo "Wait a Moment"

#sleep 5s
for i in {5..1};do echo -n "$i." && sleep 1; done
echo "Installing Repository Python-Software-Properties"
#sleep 3s
for i in {3..1};do echo -n "$i." && sleep 1; done
sudo apt install python-software-properties

echo "Add Repository Ondrej/PHP"
#sleep 3s
for i in {3..1};do echo -n "$i." && sleep 1; done
sudo add-apt-repository ppa:ondrej/php

echo "Update Added Repository Python-Software-Properties and Ondrej/PHP"
#sleep 3s
for i in {3..1};do echo -n "$i." && sleep 1; done
sudo apt-get update

echo "Installing Apache2 and libapache2-mod-FastCGI"
#sleep 3s
for i in {3..1};do echo -n "$i." && sleep 1; done
sudo apt install apache2 libapache2-mod-fastcgi

#sleep 3s
echo "Instaling php5.6 php5.6-fpm"
#sleep 3s
for i in {3..1};do echo -n "$i." && sleep 1; done
sudo apt-get install php5.6 php5.6-fpm
sudo a2enmod actions fastcgi alias proxy_fcgi
echo "Instaling module php and all component "
#sleep 3s
for i in {3..1};do echo -n "$i." && sleep 1; done   
sudo apt-get install php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-xml php5.6-zip php5.6-curl php5.6-libcrypt php5.6-intl
echo "wait a minutes, restart the apache service"
#sleep 3s
for i in {5..1};do echo -n "$i." && sleep 1; done
sudo service apahce2 graceful
sudo echo "<?php phpinfo(); ?>" > /var/www/html/info.php
sudo a2dismod mpm_event 
sudo a2enmod mpm_worker 
sudo service apache2 graceful
sudo apt-get intsall htop
sudo apt-get intsall atop
sudo a2enmod headers
sudo a2enmod rewrite
echo "Thanks, all component has been install successfull, check using ip_server/info.php"
for i in {5..1};do echo -n "$i." && sleep 1; done
echo "Thanks Bye..."
sleep 5s

