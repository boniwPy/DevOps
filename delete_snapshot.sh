#!/bin/bash
#=============================================================#
# Name     :         automation_deletesnapshot.sh             #
# Description:        Automaticaly create a snapshoot         #
# Version    :         V.Karya Anak Bangsa.1.1                #
# Author     :        DevOps@payrightsystem.com               #
# License    :  GNU General Public License, version 3 (GPLv3) #
# License URI:  http://www.gnu.org/licenses/gpl-3.0.html      #
#=============================================================#
region=ap-southeast-1
targetRegion=ap-southeast-2
jarakHari=7
tag=CreatedBy
values=Automation        
date=$(date +%Y-%m-%d --date "$jarakHari days ago")
output=text
#echo "$date"
aws ec2 describe-snapshots --filters Name=tag:$tag,Values=$values --query "Snapshots[?StartTime<=\`$date\`][].{ID: SnapshotId }" --output $output > listDelete.txt                                       
exec</home/imam/listDelete.txt                                                                                                                                                                           
k=0;
while read line
do
x=$line;
let "k+=1"
echo "$line"
#aws ec2 delete-snapshot --snapshot-id $line
#done
#echo "sukses  delete"
#rm list.txt






1. Redesign server dan script payrightdevelopment :
a. Interface
b. Proses migrasi all media to s3 bucket
c. Estimasi Harga
d. Kelebihan 
e. Kekurangan