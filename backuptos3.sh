#!/bin/bash
#=============================================================#
# Name 		 :           backuptos3.sh                        #
# Description:        Auto Dump to S3 Bucket	              #
# Version    :         V.Karya Anak Bangsa.1.1                #
# Author     :        DevOps@payrightsystem.com               #
# License    :  GNU General Public License, version 3 (GPLv3) #
# License URI:  http://www.gnu.org/licenses/gpl-3.0.html      #
#=============================================================#
tanggal=`date +%Y-%m-%d`
namafile="$tanggal.sql.gz"


mysqldump –user=user –password=password database_name | gzip -9 > $namafile

echo "Backup beres"

echo "Upload ke s3 Bucket"
s3cmd put $namafile s3://path/to/file/$namafile

echo "Sukses"

echo "Delete backup filenya"
rm $namafile

echo "Done"