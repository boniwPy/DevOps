cd /tmp
curl -O https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
touch /tmp/wordpress/.htaccess
chmod 660 /tmp/wordpress/.htaccess
cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
mkdir /tmp/wordpress/wp-content/upgrade
sudo cp -a /tmp/wordpress/. /var/www/html/trial.sumantagroup.com
sudo chown -R ubuntu:www-data /var/www/html/trial.sumantagroup.com
sudo find /var/www/html/trial.sumantagroup.com -type d -exec chmod g+s {} \;
sudo chmod g+w /var/www/html/trial.sumantagroup.com/wp-content
sudo chmod -R g+w /var/www/html/trial.sumantagroup.com/wp-content/themes
sudo chmod -R g+w /var/www/html/trial.sumantagroup.com/wp-content/plugins
curl -s https://api.wordpress.org/secret-key/1.1/salt/
