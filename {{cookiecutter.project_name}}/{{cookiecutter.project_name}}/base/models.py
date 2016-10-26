#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
    base.models
    ~~~~~~~~~~~

    This is a naive file which defines most db used abstract base models.
    Module contains:

        BaseModel
        BaseSoftDeleteModel

    :copyright: (c) 2016 by {{cookiecutter.author_name}}.
    :license: , see LICENSE for more details.
"""

from django.db import (models, router)


class BaseModel(models.Model):

    """
    This abstract base model contains 2 fields:
        created: created timestamp (auto created)
        upadted: updated timestamp (auto modified)
    """

    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True


class BaseSoftDeleteModel(models.Model):

    """
    This abstract base model contains 3 fields:
        created: created timestamp (auto created)
        upadted: updated timestamp (auto modified)
        is_deleted: indicate this record is deleted or not (default False)

    and also handle the delete() method to raise ValueError while perfroming error.
    """

    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)
    is_deleted = models.BooleanField(default=False)

    def delete(self, using=None, keep_parents=False):
        """
        Overwite built-in delete function to perform soft deletion
        """
        using = using or router.db_for_write(self.__class__, instance=self)
        assert self._get_pk_val() is not None, (
            "%s object can't be deleted because its %s attribute is set to None." %
            (self._meta.object_name, self._meta.pk.attname)
        )
        if self.is_deleted:
            raise ValueError("This object is already marked as deleted")
        self.is_deleted = True
        self.save(using=using)
        return self.is_deleted

    class Meta:
        abstract = True
