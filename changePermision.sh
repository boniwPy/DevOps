#!/bin/bash
echo -e "which folder will be changed the permision? : \n the format must like /etc/apache/ !!! "
echo "masukan folder mana yang akan di rubah permision : "(mesti dalam format /etc/apache/)""
read folder
echo "masukan folder mana yang akan di rubah permision : (mesti dalam format : 644) "
read folderPErmision
echo "masukan folder mana yang akan di rubah permision : (mesti dalam format : 775) "
read filePermision
sudo find $folder -type d -exec chmod $folderPermision {} \;
sudo find $folder -type f -exec chmod $filePermision {} \;
echo "Done"
