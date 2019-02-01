#!/bin/bash
#=============================================================#
# Name 		 :           auto_snapshoot.sh                    #
# Description:     Automaticaly to crete a snapshoot	      #
# Version    :         V.Karya Anak Bangsa.1.1                #
# Author     :        DevOps@payrightsystem.com               #
# License    :  GNU General Public License, version 3 (GPLv3) #
# License URI:  http://www.gnu.org/licenses/gpl-3.0.html      #
#=============================================================#
# Volume list file will have volume-id:Volume-name format

VOLUMES_LIST = /var/log/volumes-list
SNAPSHOT_INFO = /var/log/snapshot_info
DATE = `date +%Y-%m-%d`
REGION = "ap-southeast-1"

# Snapshots Retention Period for each volume snapshot
RETENTION=6

SNAP_CREATION = /var/log/snap_creation
SNAP_DELETION = /var/log/snap_deletion

EMAIL_LIST = abc@domain.com

echo "List of Snapshots Creation Status" > $SNAP_CREATION
echo "List of Snapshots Deletion Status" > $SNAP_DELETION

# Check whether the volumes list file is available or not?

if [ -f $VOLUMES_LIST ]; then

# Creating Snapshot for each volume using for loop

for VOL_INFO in `cat $VOLUMES_LIST`
do
# Getting the Volume ID and Volume Name into the Separate Variables.

VOL_ID = `echo $VOL_INFO | awk -F":" '{print $1}'`
VOL_NAME = `echo $VOL_INFO | awk -F":" '{print $2}'`

# Creating the Snapshot of the Volumes with Proper Description.

DESCRIPTION = "${VOL_NAME}_${DATE}"

/usr/local/bin/aws ec2 create-snapshot --volume-id $VOL_ID --description "$DESCRIPTION" --region $REGION &>> $SNAP_CREATION
done
else
echo "Volumes list file is not available : $VOLUMES_LIST Exiting." | mail -s "Snapshots Creation Status" $EMAIL_LIST
exit 1
fi

echo >> $SNAP_CREATION
echo >> $SNAP_CREATION

# Deleting the Snapshots which are 10 days old.

for VOL_INFO in `cat $VOLUMES_LIST`
do

# Getting the Volume ID and Volume Name into the Separate Variables.

VOL_ID = `echo $VOL_INFO | awk -F":" '{print $1}'`
VOL_NAME = `echo $VOL_INFO | awk -F":" '{print $2}'`

# Getting the Snapshot details of each volume.

/usr/local/bin/aws ec2 describe-snapshots --query Snapshots[*].[SnapshotId,VolumeId,Description,StartTime] --output text --filters "Name=status,Values=completed" "Name=volume-id,Values=$VOL_ID" | grep -v "CreateImage" > $SNAPSHOT_INFO

# Snapshots Retention Period Checking and if it crosses delete them.

while read SNAP_INFO
do
SNAP_ID=`echo $SNAP_INFO | awk '{print $1}'`
echo $SNAP_ID
SNAP_DATE=`echo $SNAP_INFO | awk '{print $4}' | awk -F"T" '{print $1}'`
echo $SNAP_DATE

# Getting the no.of days difference between a snapshot and present day.

RETENTION_DIFF = `echo $(($(($(date -d "$DATE" "+%s") - $(date -d "$SNAP_DATE" "+%s"))) / 86400))`
echo $RETENTION_DIFF

# Deleting the Snapshots which are older than the Retention Period

if [ $RETENTION -lt $RETENTION_DIFF ];
then
/usr/local/bin/aws ec2 delete-snapshot --snapshot-id $SNAP_ID --region $REGION --output text> /tmp/snap_del
echo DELETING $SNAP_INFO >> $SNAP_DELETION
fi
done < $SNAPSHOT_INFO
done

echo >> $SNAP_DELETION

# Merging the Snap Creation and Deletion Data

cat $SNAP_CREATION $SNAP_DELETION > /var/log/mail_report

# Sending the mail Update

cat /var/log/mail_report | mail -s "Volume Snapshots Status" $EMAIL_LIST