#!/usr/bin/env python

def portal_rows(portal, output_dir = 'rows', input_dir = 'data'):
    'Download all of the rows for one portal.'
    import os
    from urllib import urlretrieve

    portal_dir = os.path.join(output_dir, portal)
    try:
        os.makedirs(portal_dir)
    except OSError:
        pass

    for viewid_raw in open(os.path.join(input_dir, portal, 'viewids')).readlines():
        viewid = viewid_raw[:-1]
        url = 'http://%s/api/views/%s/rows.csv?accessType=DOWNLOAD' % (portal, viewid)
        urlretrieve(url, filename = os.path.join(portal_dir, viewid))
        break

import os
if 'http_proxy' in os.environ:
    nprocesses = 50
    print 'An http_proxy is set, so I am running in parallel with %d processes.' % nprocesses
    from multiprocessing import Pool
    p = Pool(nprocesses)
    p.map(portal_rows, os.listdir('data'))
else:
    print 'No http_proxy is set, so I am running in series.'
    map(portal_rows, os.listdir('data'))
