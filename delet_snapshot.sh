#!/bin/bash
REGION="ap-southeast-1"
AWS="aws"
#DATE=$(date +%Y-%m-%d)
hapus=$(date +"%Y-%m-%d" -d "8 days ago")
echo "$hapus"
#RETENTIONDAYS=7
#RETENTIONDATE=$(date +%Y-%m-%d --date "$RETENTIONDAYS days ago")
#echo "RETENTIONDATE"
#listing all snapshoot berdasarkan owner id
snapshot_id=$(aws ec2 describe-snapshots --owner-ids 838649246533 --output text | tr '\t' '\n' | sort)
echo "snapshot id nya adalah $snapshot_id"
###umur snap
variable_tanggal=$(aws ec2 describe-snapshots --owner-ids 838649246533 --output text | awk '{print $7}' | sort -n )
echo "tanggal di buat nya adalah $variable_tanggal"


interval=($DATE --date "$vabre install jw 	riable_tanggal")
echo "yang akan di hapus dari mulai tanggal $interval"

#hasil=$(aws ec2 describe-snapshots --snapshot-id $snapshot_id )

#for snapshot in $interval; do
#    aws ec2 delete-snapshot --snapshot-id $snapshot
#  done
#fi


#!/bin/bash
Hapus=$(date +"%Y-%m-%dT%k:%M:%S" -d "8 days ago")
echo "$Hapus"
Filters=$(aws ec2 describe-snapshots --owner-ids 838649246533 --query 'Snapshots[?StartTime <= "$Hapus" ].{id:SnapshotId}' --output text)
echo "$Filters"
TanggalDibuat=$(aws ec2 describe-snapshots --owner-ids 838649246533 | awk '{print $7}' | sort -n --filter [ start-time < $Hapus ]--output text )
echo "$TanggalDibuat"

