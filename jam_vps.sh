#!/bin/bash
echo " #=============================================================#"
echo " # Name 		:  Automation time.zone to +07.00                #"
echo " # Description:  	Oneclick Change Time.Region	                 #"
echo " # Version    :      V.Karya Anak Bangsa.1.1                   #"
echo " # Author     :  DevOps@payrightsystem.com                     #"
echo " # License    :  GNU General Public License, version 3 (GPLv3) #"
echo " # License URI:  http://www.gnu.org/licenses/gpl-3.0.html      #"
echo " #=============================================================#"

echo "Jam sekarang :"
date
sudo mv /etc/localtime /etc/localtime.bak
sudo ln -s /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
echo "Jam sekarang :"
date

