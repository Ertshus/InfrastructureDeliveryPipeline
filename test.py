import unittest
from app import app

class AppTestCase(unittest.TestCase):
  def test_index(self):
    tester = app.client(self)
    response = tester.get('/', content_type='html/text')
    self.assertEqual(response.status_code, 200)
    self.assertEqual(response.data, b'Hello World!!!!!!!!!')

if __name__ == '__main__':
  unittest.main()
