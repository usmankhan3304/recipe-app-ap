"""
Using  Sample Test class
"""

from django.test import SimpleTestCase

from app import calc

class CalcTests(SimpleTestCase):
    """Test the  module here!"""

    def test_add_numbers(self):
        """Test the adding numbers togethers"""
        res=calc.add(5,6)

        self.assertEqual(res,11)
    
    def test_subtract_numbers(self):
        """Test the subracts numbers togethers"""

        res=calc.subtract(10,15)
        self.assertEqual(res,5)