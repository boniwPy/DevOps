#!/bin/bash
echo -e "#==============================================================# "
echo -e  "# Name:         Script for instaling php7.2-fpm               #"
echo -e  "# Description:  Install php7.2-fpm fast-cgi at ec2 instance   #"
echo -e  "# Version:      V.Karya Anak Bangsa.1.1                       #"
echo -e  "# Author     :  DevOps@payrightsystem.com                     #"
echo -e  "# License:      GNU General Public License, version 3 (GPLv3) #"
echo -e  "# License URI:  http://www.gnu.org/licenses/gpl-3.0.html      #"
echo -e  "#=============================================================#"

echo "Wait a Moment"
echo "Jam sekarang :"
date
sudo mv /etc/localtime /etc/localtime.bak
sudo ln -s /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
echo "Jam sekarang :"
date

#sleep 5s
for i in {5..1};do echo -n "$i." && sleep 1; done
echo "Installing Repository Python-Software-Properties"
#sleep 3s
for i in {3..1};do echo -n "$i." && sleep 1; done
sudo apt-get install -y --allow-unauthenticated python-software-properties

echo "Add Repository Ondrej/PHP"
#sleep 3s
for i in {3..1};do echo -n "$i." && sleep 1; done
sudo add-apt-repository -y ppa:ondrej/php

echo "Update Added Repository Python-Software-Properties and Ondrej/PHP"
#sleep 3s
for i in {3..1};do echo -n "$i." && sleep 1; done
sudo apt-get update

echo "Instaling Composer"
sudo apt-get install -y curl php-cli php-mbstring git unzip

echo "Installing Apache2 and libapache2-mod-FastCGI"
#sleep 3s
for i in {3..1};do echo -n "$i." && sleep 1; done
sudo apt install -y --allow-unauthenticated apache2 libapache2-mod-fastcgi
sudo apt install -y zip
#sleep 3s
echo "Instaling php7.2 php7.2-fpm"
#sleep 3s
for i in {3..1};do echo -n "$i." && sleep 1; done
sudo apt-get install -y --allow-unauthenticated php7.2 php7.2-fpm
sudo a2enmod actions fastcgi alias proxy_fcgi
echo "Instaling module php and all component "
#sleep 3s
for i in {3..1};do echo -n "$i." && sleep 1; done   
sudo apt-get install -y --allow-unauthenticated php7.2-soap php7.2-gd php7.2-ldap php7.2-mbstring php7.2-mcrypt php7.2-zip php7.2-mysql php7.2-xml php7.2-zip php7.2-curl php7.2-gd php7.2-intl libapache2-mod-fastcgi php7.2-fpm php7.2 php7.2-dev php7.2-mcrypt php7.2-mbstring php7.2-mysql php7.2-zip php7.2-gd php7.2-xml
echo "wait a minutes, restart the apache service"
#sleep 3s
for i in {5..1};do echo -n "$i." && sleep 1; done
sudo service apache2 graceful

sudo echo "<?php phpinfo(); ?>" >> /var/www/html/info.php
sudo a2dismod mpm_prefork 
sudo a2enmod mpm_worker 
sudo service apache2 graceful
sudo apt-get install -y htop
sudo apt-get install -y atop
sudo a2enmod headers
sudo a2enmod rewrite
sudo a2enmod actions fastcgi alias
sudo a2enconf php7.2-fpm
sudo service apache2 reload
echo "Thanks, all component has been install successfull, check using ip_server/info.php"
for i in {5..1};do echo -n "$i." && sleep 1; done
echo "Thanks Bye..."
sleep 5s
echo "Your IP server is $(curl icanhazip.com)"
sudo service apache2 start
sudo update-alternatives --set php /usr/bin/php7.2
