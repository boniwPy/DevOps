#!/bin/bash
#=============================================================#
# Name 		:           master_slave.sh                       #
# Description: Cek status Master Slave Database Replication	  #
# Version    :         V.Karya Anak Bangsa.1.1                #
# Author     :        DevOps@payrightsystem.com               #
# License    :  GNU General Public License, version 3 (GPLv3) #
# License URI:  http://www.gnu.org/licenses/gpl-3.0.html      #
#=============================================================#
###variable####
status=0
masterip="10.0.1.138"
slaveip="10.0.1.61"
emailnya="boniw@getnada.com tes@getnada.com" 
userpass="sudo mysql --user=replication --password=Hash2856" 
subject="ROGER ROGER Replication status - Down"
###proses####
statussql=`$userpass -e "show slave status \G" |grep -i "Slave_SQL_Running"|gawk '{print $2}'`
statusIO=`$userpass -e "show slave status \G" |grep -i "Slave_IO_Running"|gawk '{print $2}'`
    if [ "$statussql" = "No" ]; then
    error="Replication at ($slaveip) has stopped working. Caused by SQL not running. Check NOW...!!!!"
    status=1
    fi
    if [ "$statusIO" = "No" ]; then
    error="Replication at ($slaveip) has stopped working. Caused by I/O STOP. Check NOW...!!!!"
    status=1
    fi
    # If the replication is not working
    if [ $status = 1 ]; then
    for address in $emailnya; do
    echo -e $error | mail -s "$subject" $address
   # echo "Replication Down, alrt has sent email to $address"
    done
    fi