
#!/bin/bash
echo -e "#==============================================================# "
echo -e  "# Name:         Script for instaling somerequirement          #"
echo -e  "# Description:  Install somerequirement for LPSE Kominfo Button   #"
echo -e  "# Version:      V.Karya Anak Bangsa.1.1                       #"
echo -e  "# Author     :  DevOps@payrightsystem.com                     #"
echo -e  "# License:      GNU General Public License, version 3 (GPLv3) #"
echo -e  "# License URI:  http://www.gnu.org/licenses/gpl-3.0.html      #"
echo -e  "#=============================================================#"

echo "This step process installing Postgresql version 10"
for i in {3..1};do echo -n "$i." && sleep 1; done

echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" >> /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
sudo apt-key add - 
sudo apt -y update
sudo apt-get install postgresql-10 postgresql-contrib libpq-dev -y
sudo systemctl start postgresql
sudo systemctl enable postgresql

for i in {3..1};do echo -n "$i." && sleep 1; done
echo "PostGreSql Installing Success"

echo "This step process installing Apache2 as a web server"
for i in {3..1};do echo -n "$i." && sleep 1; done
sudo apt install apache2 -y 

echo "This step process for installing JAVA"
for i in {3..1};do echo -n "$i." && sleep 1; done

sudo echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/java-8-debian.list
sudo echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >>  /etc/apt/sources.list.d/java-8-debian.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
sudo apt update -y
sudo apt-get install default-jre -y
sudo apt-get install default-jdk -y
sudo apt-get install software-properties-common -y
sudo apt-get update -y
sudo apt-get install oracle-java8-installer -y

echo "Done"
version"=$(javac -version)
