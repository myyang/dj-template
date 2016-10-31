#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
    {{cookiecutter.project_name}}.views
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    some basic functional views

"""

from django.views.generic.base import View
from django.http import HttpResponse


class AliveView(View):
    """
    Website alive check view
    """

    def get(self, request, *args, **kwargs):
        """HTTP GET method

        :param request: Django http request
        :returns: http response

        """
        return HttpResponse("alive")


class BadView(View):

    """Bad request which raises exception"""

    def get(self, request, *args, **kwargs):
        raise Exception("Bad View")
