#!/bin/bash
#=============================================================#
# Name     :         automation_backupsnapshot.sh           #
# Description:        Automaticaly create a snapshoot       #
# Version    :         V.Karya Anak Bangsa.1.1                #
# Author     :        DevOps@payrightsystem.com               #
# License    :  GNU General Public License, version 3 (GPLv3) #
# License URI:  http://www.gnu.org/licenses/gpl-3.0.html      #
#=============================================================#

# Specifying the region of AWS
REGION="ap-southeast-1"

# Specifying the location of aws binary
AWS="aws"

DATE=$(date +%Y-%m-%d)

# grep all volumes with tag tertentu
vol_id=$( aws ec2 describe-volumes --filters "Name=attachment.status, Values=attached" "Name=tag:environment,Values=production.database" --query 'Volumes[].Attachments[].VolumeId' --output text --region $REGION )

##Checking if volume list is empty
if [ -z "$vol_id" ]
then
   echo "There is no volume with such tag"
#else [ "$vol_id" ]
#   echo "there is instace id number $vol_id"

   exit 1
fi

# Iterating each volume
        for i in $vol_id
        do
           #Getting each instance id associated with that volume
           inst_id=$(aws ec2 describe-volumes --volume-ids $i --query 'Volumes[].Attachments[].InstanceId' --output text --region $REGION )

           #Checking the state of the above instance
           state=$(aws ec2 describe-instances --instance-ids $inst_id  --query 'Reservations[].Instances[].State[].Name' --output text --region $REGION )

           if [ $state = 'running' ]
           then
                #Getting Instance Name
                inst_name=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$inst_id" "Name=key,Values=Name" --query 'Tags[].Value' --output text --region $REGION )
                echo "$inst_name"
        #Getting volume block
                block=$(aws ec2 describe-volumes --volume-ids $i --query 'Volumes[].Attachments[].Device'  --output text --region $REGION )
                echo "$block"
        #Creating snapshot
                snapid=$(aws ec2 create-snapshot --volume-id $i --query 'SnapshotId' --description  "NewBackup|$DATE|$inst_name" --output text --region $REGION )
        echo "$snapid"
                if [ $? == 0 ]
                then
                    echo $block | grep sda1
                    if [ $? == 0 ]
                    then
                    aws ec2 create-tags --resources $snapid --tags Key=CreatedBy,Value=Automation --output text --region $REGION
                    else
                    aws ec2 create-tags --resources $snapid --tags Key=Name,Value="$DATE|secondary-disk" --output text --region $REGION
                    fi

      else

                    echo "Snapshots creation error !! ....Please Check and Resolve"
            fi

            else
        echo "stopped instance $inst_id"
  fi
        done

  echo "====================================Job executed successfully================================"