#!/bin/bash
echo -e “\e[38; merah #=============================================================# "
echo -e “\e[38; merah # Name:         Script for add a new user to aws ec2          #"
echo -e “\e[38; merah # Description:  Manambahkan userbaru tanpa password di ec2    #"
echo -e “\e[38; merah # Version:      V.Karya Anak Bangsa.1.1                       #"
echo -e “\e[38; merah # Author     :  DevOps@payrightsystem.com                     #"
echo -e “\e[38; merah # License:      GNU General Public License, version 3 (GPLv3) #"
echo -e “\e[38; merah # License URI:  http://www.gnu.org/licenses/gpl-3.0.html      #"
echo -e “\e[38; merah #=============================================================#"


echo -e “\e[38; merah Hai, mau create new user ya? ok aku bantu."
echo -e “\e[38; merah silahkan masukan nama usernya :" read newuser
echo -e “\e[38; merah nama user baru adalah $newuser"

echo -e “\e[38; merah ####add a new user to a ec2####"
sudo adduser $newuser --disabled-password
########
sudo su $newuser
cd
####add a new user to a ec2####
mkdir .ssh
####add a new user to a ec2####
chmod 700 .ssh
####add a new user to a ec2####
touch .ssh/authorized_keys
####add a new user to a ec2####
chmod 600 .ssh/authorized_keys
####add a new user to a ec2####
nano .ssh/authorized_keys