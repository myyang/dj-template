#!/bin/sh

DEV_OPT=""

if [ "$STAGING" ]; then
    DEV_OPT=" --py-autoreload 1"
fi

uwsgi --ini conf/app.ini $DEV_OPT
