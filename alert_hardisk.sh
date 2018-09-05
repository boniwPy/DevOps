#!/bin/bash
#=============================================================#
# Name 		 :           alert_hardisk.sh                     #
# Description:        Hardisk free space alert	              #
# Version    :         V.Karya Anak Bangsa.1.1                #
# Author     :        DevOps@payrightsystem.com               #
# License    :  GNU General Public License, version 3 (GPLv3) #
# License URI:  http://www.gnu.org/licenses/gpl-3.0.html      #
#=============================================================#
echo "Harap install mailutils dan postfix dahulu"
#Variable
email="boniw@getnada.com"
namapartisi="/dev/sda1"
isistorage="60" #alert jika isi storage sudah mencapi 
#Proses
persen=$(df -h | grep "$namapartisi" | awk '{ print $5 }' | sed 's/%//g')
if ((persen > isistorage))
then
echo "Storage at $(hostname -f) is nearly full" | mail -s "Roger, Roger, Your disk is nearly full!!!" "$email"
fi

