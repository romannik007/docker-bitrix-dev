#!/bin/bash

groupmod --gid $USER_GID www-data  && \
usermod --uid $USER_ID www-data && \
mkdir -p /var/log/nginx
chmod -R 777 /var/log
rm -f /var/run/*.pid
chmod -R 777 /tmp/php_sessions
chmod -R 777 /tmp/php_upload
mkdir -p /home/bitrix/.bx_temp/sitemanager
chmod -R 777 /home/bitrix/.bx_temp/sitemanager
exec /usr/bin/supervisord
