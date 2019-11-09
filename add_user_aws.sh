#!/bin/bash
echo -e "#==============================================================# "
echo -e  "# Name:         Script for instaling php5.6-fpm               #"
echo -e  "# Description:  Install php5.6-fpm fast-cgi at ec2 instance   #"
echo -e  "# Version:      V.Karya Anak Bangsa.1.1                       #"
echo -e  "# Author     :  DevOps@payrightsystem.com                     #"
echo -e  "# License:      GNU General Public License, version 3 (GPLv3) #"
echo -e  "# License URI:  http://www.gnu.org/licenses/gpl-3.0.html      #"
echo -e  "#=============================================================#"


echo "masukan nama userbaru :"
read user
sudo adduser $user --disabled-password
cd /home/$user
sudo mkdir .ssh
sudo chmod 700 .ssh
sudo chown $user:$user .ssh
#sudo cat /tmp/$user.pub >> .ssh/authorized_keys
sudo touch /home/$user/.ssh/authorized_keys
sudo chmod 600 .ssh/authorized_keys
sudo chown $user:$user .ssh/authorized_keys
sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMOJWWrEreGofTYVyugWlzDAk05u20xtreubFqkjjdlyrNtqjQFhT5iDntYV9cHFK8AMuEdLoAefA9S0WIt2+WTg+1lna1jtOTgNtlU+qQ/A130U7nZ+HcNVGCcKRtigr94AdkU4sJWiQNqCyRlK9jEtNMl19q1iNPFK48rcRITyqKanEN++MvtVurRKntTaHTUX3SV7LJ9/eZmxz9e6xNEIHVzazA8u598Dy+vYet2rDh3T0F6ecUDa48N3V/Kb5oK5tIk4jDmO9Sit42a3vZ7UZOttnqURdNZ5u2SKP9rjm2CY40flpgfdl4awzII/U1FXuv1OmIg82itNlzptLn mac@Macintoshs-MacBook-Pro.local" >> /home/$user/.ssh/authorized_keys
echo "SUKSES BOYS..."
#SLEEP 5 SECONDS
for i in {5..1};do echo -n "$i." && sleep 1; done
ECHO "SELAMAT BROW..USER SUDAH DIBUAT, SILAHKAN LOGIN DENGAN KEYS SEPERTI BERIKUT INIH.."
