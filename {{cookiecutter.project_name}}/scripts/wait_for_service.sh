#!/bin/sh

# For testing purpose, gitlab needs some time to initialize services which
# are defined in job level only. So waitting here.
# Currently test and packaged with alpine which is a quite small OS (5MB),
# the package manager would be `apk`

apk add --update mysql-client

echo "Wait MySQL"
count=0

while [ $count -lt 10 ];
do
    msg=`mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ROOT_PASSWORD" -e "select 1;"`
    exp=$(printf "1\n1")
    if [ "$msg" = "$exp" ]; then
        break
    fi
    count=`expr $count + 1`
    if [ $count -gt 9 ]; then
        echo "Retry failure for 10 times"
        exit 2
    fi
    echo "sleep 1s at $count term..."
    sleep 1
done

echo "MySQL ready"
