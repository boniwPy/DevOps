#!/bin/bash
DB_USER='root'
DB_PASS='Hash2856'
DB_NAME='payrightlight'
ID=`mysql -u$DB_USER -p$DB_PASS $DB_NAME -Bse "SELECT notification_id FROM alert_tambahbaris WHERE sent=0 LIMIT 1;"`

if [[ ! -z $ID ]] 
then
    # SEND MAIL HERE
    RESULT=`mysql -u$DB_USER -p$DB_PASS $DB_NAME -Bse "UPDATE alert_tambahbaris SET sent=1 WHERE notification_id = $ID;"`
    echo "Sent"
fi