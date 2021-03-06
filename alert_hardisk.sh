#!/bin/bash
#=============================================================#
# Name 		 :           alert_hardisk.sh                     #
# Description:        Hardisk free space alert	              #
# Version    :         V.Karya Anak Bangsa.1.1                #
# Author     :        DevOps@payrightsystem.com               #
# License    :  GNU General Public License, version 3 (GPLv3) #
# License URI:  http://www.gnu.org/licenses/gpl-3.0.html      #
#=============================================================#
#echo "Harap install mailutils dan postfix dahulu"
#Variable
email="boniw@getnada.com hardisk@getnada.com"
namapartisi="/dev/nvme0n1p1"
isistorage="90"
#Proses
persen=$(df -h | grep "$namapartisi" | awk '{ print $5 }' | sed 's/%//g')
if ((persen > isistorage))
then
for address in $email; do
echo "Storage at $(hostname -f) is nearly full" | mail -s "Roger, Roger, Your disk is nearly full !!! , Reached $isistorage Percent." $address
#echo "hardisk bahaya, alert sudah di kirim ke $address"
done
fi

