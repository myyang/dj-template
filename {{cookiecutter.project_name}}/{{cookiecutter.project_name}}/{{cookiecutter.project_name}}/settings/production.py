#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
    settings.prodcution
    ~~~~~~~~~~~~~~~~~~~

    This is the production settings.
    Please edit this carefully while deploying.

"""

from .base import *


# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = env("SECRET_KEY")
