#!/usr/bin/env python
import os
from urllib import urlretrieve

OUTPUT_DIR = 'rows'
HTTP_PROXY = os.environ['http_proxy']

for portal in os.listdir('data'):
    for viewid in open(os.path.join('data', portal, 'viewids')).readlines():
        url = 'http://%s/api/views/%s/rows.csv?accessType=DOWNLOAD' % (portal, viewid.strip())
        print url
    break
