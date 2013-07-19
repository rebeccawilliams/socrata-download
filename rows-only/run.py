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
        output_file = os.path.join(portal_dir, viewid)
        if not os.path.exists(output_file):
            url = 'http://%s/api/views/%s/rows.csv?accessType=DOWNLOAD' % (portal, viewid)
            try:
                urlretrieve(url, filename = output_file)
            except:
                return (1, url)
    return (0,)

import os
if 'http_proxy' in os.environ:
    nprocesses = 50
    print 'An http_proxy is set, so I am running in parallel with %d processes.' % nprocesses
    from multiprocessing import Pool
    p = Pool(nprocesses)
    print p.map(portal_rows, os.listdir('data'))
else:
    print 'No http_proxy is set, so I am running in series.'
    print map(portal_rows, os.listdir('data'))
