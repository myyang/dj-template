#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
    settings.prodcution
    ~~~~~~~~~~~~~~~~~~~

    This is the production settings.
    Please edit this carefully while deploying.

"""

from .base import *

INSTALLED_APPS = INSTALLED_APPS + [
    # 'django_slack',
]

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = env("SECRET_KEY")

# Database
# https://docs.djangoproject.com/en/1.10/ref/settings/#databases
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'HOST': env("DB_HOST"),
        'PORT': env("DB_PORT"),
        'NAME': env("DB_NAME"),
        'USER': env("DB_USERNAME"),
        'PASSWORD': env("DB_PASSWORD"),
        'ENCODING': 'utf-8',
    }
}

# Caches
# https://docs.djangoproject.com/es/1.10/topics/cache/#django-s-cache-framework
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
        'LOCATION': [env("CACHE_HOST")],
    },
}

ADMINS = (
    ('{{cookiecutter.author_name}}', '{{cookiecutter.author_email}}'),
)
MANAGERS = ADMINS

EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = env('EMAIL_HOST')
EMAIL_HOST_PASSWORD = env('EMAIL_PASS')
EMAIL_HOST_USER = env('EMAIL_USER')
EMAIL_PORT = env('EMAIL_PORT')
EMAIL_SUBJECT_PREFIX = SYSTEM_EMAIL_PREFIX
EMAIL_USE_TLS = True
SERVER_EMAIL = EMAIL_HOST_USER

# Celery
BROKER_URL = 'redis://' + env("REDIS_HOST_DB")
CELERY_RESULT_BACKEND = 'redis://' + env("REDIS_HOT_DB")

# # Slack
# SLACK_TOKEN = env('SLACK_TOKEN')
# SLACK_CHANNEL = 'django-am'
# SLACK_USERNAME = 'django-am-bot'
#
# # Logging
# LOGGING['handlers']['slack_admins'] = {
#     'level': 'ERROR',
#     'filters': ['require_debug_false'],
#     'class': 'django_slack.log.SlackExceptionHandler'
# }
# LOGGING['loggers'].update({
#     'django': {
#         'handlers': ['console', 'slack_admins', ],
#     },
#     'django.security.DisallowedHost': {
#         'handlers': ['slack_admins', ],
#         'propagate': False,
#     },
#     'django.request': {
#         'handlers': ['mail_admins', 'slack_admins', ],
#         'level': 'ERROR',
#         'propagate': False,
#     }
# })
