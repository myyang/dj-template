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
    # for local run
    # 'default': {
    #     'ENGINE': 'django.db.backends.sqlite3',
    #     'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    # }
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
    # for local run
    # 'default': {
    #     'BACKEND': 'django.core.cache.backends.dummy.DummyCache',
    # },
}

ADMINS = (
    ('{{cookiecutter.author_name}}', '{{cookiecutter.author_email}}'),
)
MANAGERS = ADMINS

EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'mailserv'
EMAIL_HOST_PASSWORD = 'mail_passwd'
EMAIL_HOST_USER = 'mail_sender'
EMAIL_PORT = 25
EMAIL_SUBJECT_PREFIX = SYSTEM_EMAIL_PREFIX
EMAIL_USE_TLS = True
SERVER_EMAIL = EMAIL_HOST_USER
# for local run
# EMAIL_BACKEND = 'django.core.mail.backends.filebased.EmailBackend'
# EMAIL_FILE_PATH = '/tmp/app-message

# Celery
BROKER_URL = 'redis://redis/2'
CELERY_RESULT_BACKEND = 'redis://redis/3'

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'filters': {
        'require_debug_false': {
            '()': 'django.utils.log.RequireDebugFalse',
        },
        'require_debug_true': {
            '()': 'django.utils.log.RequireDebugTrue',
        },
    },
    'handlers': {
        'console': {
            'level': 'INFO',
            'filters': ['require_debug_true'],
            'class': 'logging.StreamHandler',
        },
        'mail_admins': {
            'level': 'ERROR',
            'filters': ['require_debug_false'],
            'class': 'django.utils.log.AdminEmailHandler'
        },
    },
    'loggers': {
        'django': {
            'handlers': ['console', ],
        },
        'django.security.DisallowedHost': {
            'handlers': ['mail_admins', ],
            'propagate': False,
        },
        'django.request': {
            'handlers': ['mail_admins', ],
            'level': 'ERROR',
            'propagate': False,
        },
        'py.warnings': {
            'handlers': ['console'],
        },
    }
}
