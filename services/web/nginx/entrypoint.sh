#!/bin/sh

mkdir -p /var/log/nginx /var/log/crond/
chmod -R 777 /var/log
mkdir -p /home/bitrix/.bx_temp/sitemanager
chmod -R 777 /home/bitrix/.bx_temp/sitemanager
groupmod --gid $USER_GID nginx  && \
usermod --uid $USER_ID nginx
#sed -i "s/\$host;/\$host:$BITRIX_PORT;/g" /etc/nginx/sites-available/default.conf


#mkdir -p /tmp/session
#chmod -R 777 /tmp/session
#mkdir -p /var/lib/php/session
#chmod -R 777 /var/lib/php/session
#mkdir -p /tmp/php_upload
#chmod -R 777 /tmp/php_upload
#exec nginx -g "daemon off;"
# /docker-entrypoint.sh
