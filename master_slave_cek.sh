#!/bin/sh
echo -e "#=============================================================# "
echo -e  "# Name:         Script for instaling php5.6-fpm               #"
echo -e  "# Description:  Install php5.6-fpm fast-cgi di instance ec2   #"
echo -e  "# Version:      V.Karya Anak Bangsa.1.1                       #"
echo -e  "# Author     :  DevOps@payrightsystem.com                     #"
echo -e  "# License:      GNU General Public License, version 3 (GPLv3) #"
echo -e  "# License URI:  http://www.gnu.org/licenses/gpl-3.0.html      #"
echo -e  "#=============================================================#"


repeat_alert_interval=30        # minutes for lock file life
lock_file=/tmp/slave_alert.lck  # location of lock file

EMAIL=YOURNAME@YOURCOMPANY.DOM  # where to send alerts
SSTATUS=/tmp/sstatus            # location of sstatus file

### Code -- do not edit below ##
NODE=`uname -n`
## Check if alert is locked ##
function check_alert_lock () {
    if [ -f $lock_file ] ; then
        current_file=`find $lock_file -cmin -$repeat_alert_interval`
        if [ -n "$current_file" ] ; then
            # echo "Current lock file found"
            return 1
        else
            # echo "Expired lock file found"
            rm $lock_file
            return 0
        fi
    else
        touch $lock_file
    return 0
    fi
}

SLAVE=mysql

$SLAVE -e 'SHOW SLAVE STATUS\G' > $ 

function extract_value {
    FILENAME=$1
    VAR=$2
    grep -w $VAR $FILENAME | awk '{print $2}'
}

Master_Binlog=$(extract_value $SSTATUS Master_Log_File )
Master_Position=$(extract_value $SSTATUS Read_Master_Log_Pos )
Master_Host=$(extract_value $SSTATUS Master_Host)
Master_Port=$(extract_value $SSTATUS Master_Port)
Master_Log_File=$(extract_value $SSTATUS Master_Log_File)
Read_Master_Log_Pos=$(extract_value $SSTATUS Read_Master_Log_Pos)
Slave_IO_Running=$(extract_value $SSTATUS Slave_IO_Running)
Slave_SQL_Running=$(extract_value $SSTATUS Slave_SQL_Running)
Slave_ERROR=$(extract_value $SSTATUS Last_Error)

ERROR_COUNT=0
if [ "$Master_Binlog" != "$Master_Log_File" ]
then
    ERRORS[$ERROR_COUNT]="master binlog ($Master_Binlog) and Master_Log_File         ($Master_Log_File) differ"
    ERROR_COUNT=$(($ERROR_COUNT+1))
fi

POS_DIFFERENCE=$(echo ${Master_Position}-${Read_Master_Log_Pos}|bc)

if [ $POS_DIFFERENCE -gt 1000 ]
then
    ERRORS[$ERROR_COUNT]="The slave is lagging behind of $POS_DIFFERENCE"
    ERROR_COUNT=$(($ERROR_COUNT+1))
fi

if [ "$Slave_IO_Running" == "No" ]
then
    ERRORS[$ERROR_COUNT]="Replication is stopped"
    ERROR_COUNT=$(($ERROR_COUNT+1))
fi

if [ "$Slave_SQL_Running" == "No" ]
then
    ERRORS[$ERROR_COUNT]="Replication (SQL) is stopped"
    ERROR_COUNT=$(($ERROR_COUNT+1))
fi

if [ $ERROR_COUNT -gt 0 ]
then
    if [ check_alert_lock == 0 ]
        then
          SUBJECT="${NODE}-ERRORS in replication"
          BODY=''
          CNT=0
          while [ "$CNT" != "$ERROR_COUNT" ]
          do
             BODY="$BODY ${ERRORS[$CNT]}"
             CNT=$(($CNT+1))
          done
          BODY=$BODY" \n${Slave_ERROR}"
          echo $BODY  | mail -s "$SUBJECT" $EMAIL
        fi
else
    echo "Replication OK"
fi