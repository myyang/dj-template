#!/bin/sh

DEV_OPT=""

if [ "$STAGING" ]; then
    DEV_OPT=" --py-autoreload 1"
fi

uwsgi --ini conf/uwsgi/emperor.ini $DEV_OPT
