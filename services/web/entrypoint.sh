#!/bin/bash


groupmod --gid $USER_GID www-data  && \
usermod --uid $USER_ID www-data && \
mkdir -p /var/log/nginx
chmod -R 777 /var/log
rm -f /var/run/*.pid
mkdir -p /tmp/php_sessions && chmod -R 777 /tmp/php_sessions
mkdir -p /tmp/php_upload && chmod -R 777 /tmp/php_upload
mkdir -p /home/bitrix/.bx_temp/sitemanager
chmod -R 777 /home/bitrix/.bx_temp/sitemanager
chown www-data:www-data /var/www
ln -s /user/.ssh /var/www/.ssh 
chown www-data:www-data /var/www/.ssh
cd /etc/apache2/mods-available/ && a2enmod * 
cd /etc/apache2/mods-available/ && a2dismod dav_fs dav dav_lock mpm_worker
exec /usr/bin/supervisord
