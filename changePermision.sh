#!/bin/bash
echo -e "#==============================================================# "
echo -e  "# Name:         Automation change permision on linux          #"
echo -e  "# Description:  change persmision linux                       #"
echo -e  "# Version:      V.Karya Anak Bangsa.1.1                       #"
echo -e  "# Author     :  DevOps@blibli.com                             #"
echo -e  "# License:      GNU General Public License, version 3 (GPLv3) #"
echo -e  "# License URI:  http://www.gnu.org/licenses/gpl-3.0.html      #"
echo -e  "#=============================================================#"
echo -e "which folder will be changed the permision? : \n the format must like /etc/apache/ !!! "
echo "masukan folder mana yang akan di rubah permision : "(mesti dalam format /etc/apache/)""
read folder
echo "masukan fol
der mana yang akan di rubah permision : (mesti dalam format : 644) "
read folderPErmision
echo "masukan folder mana yang akan di rubah permision : (mesti dalam format : 775) "
read filePermision
sudo find $folder -type d -exec chmod $folderPermision {} \;
sudo find $folder -type f -exec chmod $filePermision {} \;
echo "Done"
