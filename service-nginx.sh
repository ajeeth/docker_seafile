#!/bin/sh

set -eu

sed -i -e "s/%SEAFILE_DOMAIN_NAME%/"$SEAFILE_DOMAIN_NAME"/g" /etc/nginx/sites-available/seafile

/usr/sbin/nginx -g "daemon off;" >> /var/log/nginx/service-nginx.log 2>&1
