from python:3.5.2-alpine

maintainer "ymy1019@gmail.com"

run apk add --update alpine-sdk

# uwsgi
run apk add musl-dev linux-headers pcre-dev python-dev build-base

# mysqlclient
run apk add mariadb-dev

# docker client
run apk add --update docker

# docker-compose
run pip install docker-compose
