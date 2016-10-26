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
