apt update
apt upgrade
sudo apt-get install php5.6-geoip php5.6-dev libgeoip-dev php5.6-xml
#instaling module geoip
sudo apt install geoip-bin geoip-database libapache2-mod-geoip libgeoip1
sudo pecl install geoip
sudo apt-get install geoip-database-extra php-geoip
sudo a2enmod geoip

cd /usr/share/GeoIP/
ls
rm GeoIP.dat
wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz
gunzip GeoIP.dat.gz
wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
gunzip GeoLiteCity.dat.gz
wget http://download.maxmind.com/download/geoip/database/asnum/GeoIPASNum.dat.gz
gunzip GeoIPASNum.dat.gz
ls

nano /etc/apache2/mods-enabled/geoip.conf
on GeoLiteCountry


cd

<?php
$geoip_country_code = getenv(GEOIP_COUNTRY_CODE);
echo $geoip_country_code;
?>



sudo mv .htaccess htaccess
sudo a2enmod geoip
sudo apt-get install php5.6-geoip
sudo apt-get install php5.6-dev
sudo apt-get install libgeoip-dev
sudo pecl install geoip
sudo apt-get install libapache2-mod-geoip
sudo apt-get install geopip-datbase geoip-database-extra php-geoip
sudo apt-get install geoip-database-extra php-geoip
sudo apt search geoip
sudo apt search geoip | less
sudp apt-get install geoip-bin
sudo apt-get install geoip-bin



RewriteEngine On
RewriteCond %{REQUEST_URI} !^/(en/|index\.php) [NC]
RewriteCond %{ENV:GEOIP_COUNTRY_CODE} !^ID$
RewriteCond %{HTTP_HOST} www.payrightsystem\.com$ [NC] 
RewriteCond %{HTTP_HOST} !en [NC]
RewriteRule ^(.*)$ /en/$1 [R,L]

<FilesMatch ".(css|png|svg|js)$">
		Header set Cache-Control "max-age=2592000, public"
		Allow From All
</FilesMatch>




apt update
apt upgrade
apt install geoip-bin geoip-database libapache2-mod-geoip libgeoip1