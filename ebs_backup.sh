#!/bin/bash
#=============================================================#
# Name 		 :           ebs_backup.sh                        #
# Description:        Automaticaly create a snapshoot	      #
# Version    :         V.Karya Anak Bangsa.1.1                #
# Author     :        DevOps@payrightsystem.com               #
# License    :  GNU General Public License, version 3 (GPLv3) #
# License URI:  http://www.gnu.org/licenses/gpl-3.0.html      #
#=============================================================#

#email untuk mengirim pemberitahuan
email=boniw@getnada.com

# aws region
REGION="ap-southeast-1"

# awscli
AWS="aws"

DATE=$(date +%Y-%m-%d-%H:%M)

# Getting all volumes with tag $Yang_akan_di_snap
vol_id=$( aws ec2 describe-volumes --filters "Name=attachment.status, Values=attached" "Name=tag:environment,Values=production.database" --query 'Volumes[].Attachments[].VolumeId' --output text --region $REGION )

# Cek Volumeid 
if [ -z "$vol_id" ]
then
   echo "There is no volume with such tag"
   exit 1
fi

# Iterating each volume
        for i in $vol_id
        do
           echo "Getting each instance id associated with that volume"
           inst_id=$(aws ec2 describe-volumes --volume-ids $i --query 'Volumes[].Attachments[].InstanceId' --output text --region $REGION )

           echo "Checking the state of the above instance"
           state=$(aws ec2 describe-instances --instance-ids $inst_id  --query 'Reservations[].Instances[].State[].Name' --output text --region $REGION )

           if [ $state = 'running' ]
           then
                echo "Getting Instance Name"
                inst_name=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$inst_id" "Name=key,Values=Name" --query 'Tags[].Value' --output text --region $REGION )
                echo "$inst_name"
				echo "Getting volume block"
                block=$(aws ec2 describe-volumes --volume-ids $i --query 'Volumes[].Attachments[].Device'  --output text --region $REGION )
                echo "$block"
				echo "Creating snapshot"
                snapid=$(aws ec2 create-snapshot --volume-id $i --query 'SnapshotId' --description  "New Automated-SnapShot-$inst_name-$block-$DATE" --output text --region $REGION )
				echo "$snapid"
                if [ $? == 0 ]
                then
                    echo $block | grep sda1
                    if [ $? == 0 ]
                    then
                    aws ec2 create-tags --resources $snapid --tags Key=Name,Value="$inst_name-new_snaphoot-" --output text --region $REGION
                    else
                    aws ec2 create-tags --resources $snapid --tags Key=Name,Value="$inst_name-new-snap-from-secondary-disk" --output text --region $REGION
                    fi

	  	else

                    echo "Snapshots creation error !! ....Please Check and Resolve"
			      fi

            else
     		echo "stopped instance $inst_id"
	fi
       
    #sudo cat $inst_id $inst_name $REGION $snapid > /home/ubuntu/log_snapshoot
    echo "Snapshot has been created dengan id = $inst_name pada jam = $(date)" | mail -s "snapshoot created $snapid jam $(date)" $email
  done
  echo "====================================Job executed successfully================================"
 