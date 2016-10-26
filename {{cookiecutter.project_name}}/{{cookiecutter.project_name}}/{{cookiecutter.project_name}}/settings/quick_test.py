#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
    settings.quick_test
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Settings for quick test
    1. SQLite as in-memeory db
    2. in-memory cache
    3. console email output

    Please sync production.py manually to assign naive params

"""

from .base import *

SECRET_KEY = 'this-is-fake-key-for-testing'

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'ENCODING': 'utf-8',
    }
}

CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
    },
}

EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'
EMAIL_HOST = ""
EMAIL_HOST_PASSWORD = ""
EMAIL_HOST_USER = ""
EMAIL_PORT = 25
EMAIL_SUBJECT_PREFIX = SYSTEM_EMAIL_PREFIX
EMAIL_USE_TLS = True
SERVER_EMAIL = EMAIL_HOST_USER
