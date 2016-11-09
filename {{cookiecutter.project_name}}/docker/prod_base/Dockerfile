from python:{{cookiecutter.python_version}}-alpine

maintainer "{{cookiecutter.author_email}}"

run apk add --update alpine-sdk

# uwsgi
run apk add musl-dev linux-headers pcre-dev python-dev build-base

# mysqlclient
run apk add mariadb-dev
