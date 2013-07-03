#!/usr/bin/env python2
import os, json
from urllib2 import urlopen

# Download.
portals = json.load(urlopen('http://status.socrata.com/sites'))

# Make a directory for each portal.
for portal in portals:
    domain = portal['description']
    try:
        os.makedirs(os.path.join('data', domain))
    except OSError, e:
        if e.args[0] != 17:
            raise

