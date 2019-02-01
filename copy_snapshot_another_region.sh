#!bin/bash
owner=838649246533
region=ap-southeast-1
targetRegion=eu-west-2
tag=CreatedBy
values=Automation_staging
aws ec2 describe-snapshots --region ap-southeast-1 --filters Name=tag:$tag,Values=$values --output text --owner-ids $owner | sort -k 7 | awk '{print $6}' > hasil.txt
grep -i "snap" hasil.txt > hasil_lagi.txt
snapTerbaru=`tail -1 hasil_lagi.txt`
aws --region $targetRegion ec2 copy-snapshot --source-region $region --source-snapshot-id $snapTerbaru 
rm hasil.txt
rm hasil_lagi.txt