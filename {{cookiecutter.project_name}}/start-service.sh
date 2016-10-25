#!/bin/sh

if [ "$STAGING" ]; then
    export DB_NAME="$MYSQL_DATABASE"
    export DB_USERNAME="$MYSQL_USER"
    export DB_PASSWORD="$MYSQL_PASSWORD"
    export DB_ADDR="$MYSQL_PORT_3306_TCP_ADDR"
    export DB_PORT="$MYSQL_PORT_3306_TCP_PORT"
    export CACHE_URL="$MEMCACHED_PORT_11211_TCP_ADDR:$MEMCACHED_PORT_11211_TCP_PORT"
fi

uwsgi --ini conf/app.ini
