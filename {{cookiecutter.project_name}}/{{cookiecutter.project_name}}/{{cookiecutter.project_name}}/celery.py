#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
    {{cookiecutter.project_name}}.celery
    ~~~~~~~~~~~~~~~~~~

    celery configs
    NOTE: copied and modified from http://github.com/pydanny/cookiecutter-django

"""


from __future__ import absolute_import

import os

from celery import Celery
from django.conf import settings

if not settings.configured:
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', '{{cookiecutter.project_name}}.settings')

app = Celery('{{cookiecutter.project_name}}')

app.config_from_object('django.conf:settings')
app.autodiscover_tasks(lambda: settings.INSTALLED_APPS)


@app.task(bind=True)
def debug_task(self):
    print('Request: {0!r}'.format(self.request))
