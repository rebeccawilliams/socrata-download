#!/usr/bin/env python2
import os
from urllib2 import urlopen
from lxml.html import fromstring

# Download.
html = fromstring(urlopen('http://www.socrata.com/customer-spotlight/').read())
# Consider adding http://status.socrata.com/sites

# Get portal urls.
portals = [unicode(t.strip()) for t in html.xpath('//p[strong[a[img[starts-with(@class, "alignnone size-full wp-image")]]]]/text()')]

# Make a directory for each portal.
for portal in portals:
    try:
        os.makedirs(os.path.join('data', portal))
    except OSError, e:
        if e.args[0] != 17:
            raise

