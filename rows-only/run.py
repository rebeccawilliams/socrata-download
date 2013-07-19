#!/usr/bin/env python
import os
from urllib import urlretrieve

OUTPUT_DIR = 'rows'
INPUT_DIR = 'data'

try:
    os.mkdir(OUTPUT_DIR)
except OSError:
    pass

for portal in os.listdir(INPUT_DIR):
    for viewid_raw in open(os.path.join(INPUT_DIR, portal, 'viewids')).readlines():
        viewid = viewid_raw[:-1]
        portal = 'explore.data.gov'
        viewid = 'bxfh-jivs'
        url = 'http://%s/api/views/%s/rows.csv?accessType=DOWNLOAD' % (portal, viewid)
        urlretrieve(url, filename = os.path.join(OUTPUT_DIR, viewid))
        break
    break
