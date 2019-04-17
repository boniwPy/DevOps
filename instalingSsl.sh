#!/bin/bash
echo -e "#==============================================================# "
echo -e  "# Name:         Script for put files into GCP Storage         #"
echo -e  "# Description:  Install php5.6-fpm fast-cgi at ec2 instance   #"
echo -e  "# Version:      V.Karya Anak Bangsa.1.1                       #"
echo -e  "# Author     :  DevOps@blibli.com                                     #"
echo -e  "# License:      GNU General Public License, version 3 (GPLv3) #"
echo -e  "# License URI:  http://www.gnu.org/licenses/gpl-3.0.html      #"
echo -e  "#=============================================================#"

sudo add-apt-repository ppa:certbot/certbot ;
sudo apt-get update ;
sudo apt-get install python-certbot-apache ;

