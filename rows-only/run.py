#!/usr/bin/env python
import os

from requests import get

for portal in os.listdir('data'):
    for viewid in open(os.path.join('data', portal, 'viewids')).readlines():
        url = 'http://%s/api/views/%s/rows.csv?accessType=DOWNLOAD' % (portal, viewid.strip())
        print url
    break
