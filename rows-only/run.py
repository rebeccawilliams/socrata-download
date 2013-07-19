#!/usr/bin/env python
import os
from urllib import urlretrieve

OUTPUT_DIR = 'rows'
INPUT_DIR = 'data'

def portal_rows(portal):
    portal_dir = os.path.join(OUTPUT_DIR, portal)
    try:
        os.makedirs(portal_dir)
    except OSError:
        pass

    for viewid_raw in open(os.path.join(INPUT_DIR, portal, 'viewids')).readlines():
        viewid = viewid_raw[:-1]
        url = 'http://%s/api/views/%s/rows.csv?accessType=DOWNLOAD' % (portal, viewid)
        urlretrieve(url, filename = os.path.join(portal_dir, viewid))
        break

if 'http_proxy' not in os.environ:
    raise UserWarning('You have not set an http_proxy.')

for portal in os.listdir(INPUT_DIR):
    portal_rows(portal)
