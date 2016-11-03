#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
    settings.local
    ~~~~~~~~~~~~~~

    This is local settings for developing on local machine
    For staging server please check proudction.py

"""

from .base import *

DEBUG = True
STAGING = True

SECRET_KEY = 'fake-secret-key-for-development'

# Database
# https://docs.djangoproject.com/en/1.10/ref/settings/#databases
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'HOST': 'mysql',
        'PORT': 3306,
        'NAME': '{{cookiecutter.project_name}}',
        'USER': '{{cookiecutter.project_name}}_user',
        'PASSWORD': '{{cookiecutter.project_name}}_passwd',
        'ENCODING': 'utf-8',
    }
}

# Caches
# https://docs.djangoproject.com/es/1.10/topics/cache/#django-s-cache-framework
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
        'LOCATION': ['memcached:11211'],
    },
    # 'persist': {
    #     'BACKEND': 'redis_cache.RedisCache',
    #     'LOCATION': ['redis:6379'],
    #     'OPTIONS': {
    #         'DB': 0,
    #     },
    # }
}

ADMINS = (
    ('{{cookiecutter.author_name}}', '{{cookiecutter.author_email}}'),
)
MANAGERS = ADMINS

EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'mailserv'
EMAIL_HOST_PASSWORD = 'mail_sender'
EMAIL_HOST_USER = 'mail_passwd'
EMAIL_PORT = 25
EMAIL_SUBJECT_PREFIX = SYSTEM_EMAIL_PREFIX
EMAIL_USE_TLS = True
SERVER_EMAIL = EMAIL_HOST_USER

# Celery
BROKER_URL = 'redis://redis/2'
CELERY_RESULT_BACKEND = 'redis://redis/3'
