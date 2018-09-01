#!/bin/bash

# Based on https://gist.github.com/2206527
echo ""
echo -e " #=====================================================================# "
echo -e  "# Name:         Backup Database To s3                                 #"
echo -e  "# Description:  Fork From S3 MySQL Backup Script v.0.1 © oodavid 2012 #"
echo -e  "# Version:      V.Karya Anak Bangsa.1.1                               #"
echo -e  "# Author     :  DevOps@payrightsystem.com                             #"
echo -e  "# License:      GNU General Public License, version 3 (GPLv3)         #"
echo -e  "# License URI:  http://www.gnu.org/licenses/gpl-3.0.html              #"
echo -e  "#=====================================================================#"

# Be pretty
echo -e " "
echo -e " .  ____  .    ______________________________"
echo -e " |/      \|   |                              |"
echo -e "[| \e[1;31m♥    ♥\e[00m |]  | S3 MySQL Backup Script v.0.1 |"
echo -e " |___==___|  /                © oodavid 2012 |"
echo -e "              |______________________________|"
echo -e " "

# Basic variables

echo "Silahkan masukan Password root mysql :" read $mysqlpass
mysqlpass=$mysqlpass
echo "Silahkan Masukan link S3 Uri anda :"
read $s3bucketname
bucket= $s3bucketname

# Timestamp (sortable AND readable)
stamp=`date +"%s - %A %d %B %Y @ %H%M"`

# List all the databases
databases=`mysql -u root -p$mysqlpass -e "SHOW DATABASES;" | tr -d "| " | grep -v "\(Database\|information_schema\|performance_schema\|mysql\|test\)"`

# Feedback
echo -e "Dumping to \e[1;32m$bucket/$stamp/\e[00m"

# Loop the databases
for db in $databases; do

  # Define our filenames
  filename="$stamp - $db.sql.gz"
  tmpfile="/tmp/$filename"
  object="$bucket/$stamp/$filename"

  # Feedback
  echo -e "\e[1;34m$db\e[00m"

  # Dump and zip
  echo -e "  creating \e[0;35m$tmpfile\e[00m"
  mysqldump -u root -p$mysqlpass --force --opt --databases "$db" | gzip -c > "$tmpfile"

  # Upload
  echo -e "  uploading..."
  s3cmd put "$tmpfile" "$object"

  # Delete
  rm -f "$tmpfile"

done;

# Jobs a goodun
echo -e "\e[1;32mSudah Beres Bos\e[00m"