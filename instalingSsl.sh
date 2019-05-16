#!/bin/bash
echo -e "#==============================================================# "
echo -e  "# Name:         automation installing ssl                     #"
echo -e  "# Description:  Install SLL with FULL Automaticaly            #"
echo -e  "# Version:      V.Karya Anak Bangsa.1.1                       #"
echo -e  "# Author     :  DevOps@payrightsystem.com                     #"
echo -e  "# License:      GNU General Public License, version 3 (GPLv3) #"
echo -e  "# License URI:  http://www.gnu.org/licenses/gpl-3.0.html      #"
echo -e  "#=============================================================#"

sudo add-apt-repository ppa:certbot/certbot ;
sudo apt-get update ;
sudo apt-get install python-certbot-apache ;
echo -e "Please Input Your Domain Name !!!"
read domain
echo -e "Please input your email address..!!!"
read EMAIL
sudo certbot run -d $domain -m $EMAIL --agree-tos

