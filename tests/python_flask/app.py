import unittest

from python_flask.app import hello_world


class AppTestCase(unittest.TestCase):

    def test_hello_world__return_hello_world_page(self):
        # Setup
        compare_value = '<p>Hello, World!</p>'

        # Act
        act = hello_world()

        # Assert
        self.assertEqual(compare_value, act)
