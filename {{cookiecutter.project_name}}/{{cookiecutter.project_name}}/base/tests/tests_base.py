from django.test import TestCase

from base import models


class TestSoftDeleteModel(TestCase):

    """Test model deletion"""

    def test_soft_deletion(self):
        t = models.TestSDModel.objects.create()
        self.assertFalse(t.is_deleted)

        t.delete()
        self.assertTrue(t.is_deleted)

        self.assertRaises(ValueError, t.delete)
