# usage: python3 get_url.py "https://docs.python.org/3.6/library/urllib.parse.html"
import sys
from urllib.parse import urlparse
url = sys.argv[1]
print(urlparse(url).netloc.replace('.','_'))



# echo 'https://docs.python.org/3.6/library/urllib.parse.html' | python3 -c 'import sys; from urllib.parse import urlparse; url = sys.argv[0]; print(urlparse(url).netloc)'