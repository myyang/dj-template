#!/bin/sh

cp -f /etc/nginx/conf.d/default.tpl /etc/nginx/conf.d/default.conf

for p in SERVER_NAME
do
    eval value=\$$p
    sed -i "s|\${${p}}|${value}|g" /etc/nginx/conf.d/default.conf
done

echo "Nginx running..."
nginx -g "daemon off;"
