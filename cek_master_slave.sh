#!/bin/bash
#=============================================================#
# Name 		:           cek_master_slave.sh                   #
# Description: Cek status Master Slave Database Replication	  #
# Version    :         V.Karya Anak Bangsa.1.1                #
# Author     :        DevOps@payrightsystem.com               #
# License    :  GNU General Public License, version 3 (GPLv3) #
# License URI:  http://www.gnu.org/licenses/gpl-3.0.html      #
#=============================================================#
ipmaster="10.0.1.138"
ipslave="10.0.1.61"
emailnya="boniw@getnada.com"
HOST="sudo mysql --user=replication --password=Hash2856" 


SQLresponse=$($HOST -e "show slave status \G" |grep -i "Slave_SQL_Running"|gawk '{print $2}')
IOresponse=$($HOST -e "show slave status \G" |grep -i "Slave_IO_Running"|gawk '{print $2}')
SSTATUS=$($HOST -e "SHOW SLAVE STATUS\G" | egrep "Master_Host|Master_User|Master_Log_File|Slave_IO_Running|Slave_SQL_Running|Last_Errno|Last_Error|Seconds_Behind_Master")
SLAVEBEHIND=$($HOST -e "show slave status \G" |grep -i "Seconds_Behind_Master"|gawk '{print $2}')



if [ "$SQLresponse" == "No" ]
 then
       ERRMSG="Replication on the slave MySQL server($ipslave) has stopped working"$'\n'"$SSTATUS"
    DownSubject="Replication Status Down on $ipslave"
      status=1
elif [ "$IOresponse" == "No" ]
 then
      ERRMSG="Replication on the slave MySQL server($ipslave) has stopped working"$'\n'"$SSTATUS"
      DownSubject="Replication Status Down on $ipslave"
   status=1
elif [ "$SLAVEBEHIND" == "NULL" ]
 then
  ERRMSG="The Slave is reporting 'NULL' (Seconds_Behind_Master)"$'\n'"$SSTATUS"
  DownSubject="Replication Status Down on $ipslave"
  status=1
elif [ "$SLAVEBEHIND" != 0 ]
 then
    ERRMSG="The Slave is at least $SLAVEBEHIND seconds behind the master (Seconds_Behind_Master)"$'\n'"$SSTATUS" 
 DownSubject="Replication Status Lag Behind $SLAVEBEHIND on $ipslave"
 status=1
else
 GoodSubject="Replication Status UP on $ipslave"
    GoodMessage="MySQL replication on $ipslave is working fine"$'\n'"$SSTATUS"
 status=0
fi
#kirim email
if [ $status == 1 ]
 then
      for address in $emails; do
                 $ERRMSG | mail -s "$DownSubject" $address 
                  $ipslave Replication down, sent email to $address"$'\n'"$ERRMSG" 
      done
fi
echo "sukses"