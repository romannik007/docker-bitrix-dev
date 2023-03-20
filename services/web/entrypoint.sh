#!/bin/bash


groupmod --gid $USER_GID www-data  && \
usermod --uid $USER_ID www-data && \
mkdir -p /var/log/nginx
chmod -R 777 /var/log
rm -f /var/run/*.pid
mkdir -p /tmp/php_sessions && chmod -R 777 /tmp/php_sessions
mkdir -p /tmp/php_upload && chmod -R 777 /tmp/php_upload
mkdir -p /home/bitrix/.bx_temp/sitemanager
mkdir -p /var/log/xhprof && chown -R www-data:www-data /var/log/xhprof
chmod -R 777 /home/bitrix/.bx_temp/sitemanager
chown www-data:www-data /var/www
ln -s /user/.ssh /var/www/.ssh 
chown www-data:www-data /var/www/.ssh
cd /etc/apache2/mods-available/ && a2enmod * 
cd /etc/apache2/mods-available/ && a2dismod dav_fs dav dav_lock mpm_worker
echo "extension=xhprof.so" > /etc/php/$PHP_VER/mods-available/xhprof.ini
echo "xhprof.output_dir=/var/log/xhprof/xhprof.log" >> /etc/php/$PHP_VER/mods-available/xhprof.ini
if [ $XHPROF_ENABLE == "0" ]; then
    phpdismod xhprof
fi
if [ $XHPROF_ENABLE == "1" ]; then
    phpdenmod xhprof
fi
exec /usr/bin/supervisord
