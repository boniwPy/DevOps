#!/bin/bash
#=============================================================#
# Name 		 :           alert_hardisk.sh                     #
# Description:        Hardisk free space alert	              #
# Version    :         V.Karya Anak Bangsa.1.1                #
# Author     :        DevOps@payrightsystem.com               #
# License    :  GNU General Public License, version 3 (GPLv3) #
# License URI:  http://www.gnu.org/licenses/gpl-3.0.html      #
#=============================================================#
#Variable
email="boniw@getnada.com"
partisi="/dev/nvme0n1p1"
sudah="75"
#Proses
persen=$(df -h | grep "$partisi" | awk '{ print $5 }' | sed 's/%//g')
if ((persen > sudah))
then
echo "Storage at $(hostname -f) is nearly full" | mail -s "Roger, Roger, Your disk is nearly full!!!" "$email"
fi

