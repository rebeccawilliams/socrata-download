#!/usr/bin/env python2
import os, json, warnings
from urllib2 import urlopen

# Download.
portals = json.load(urlopen('http://status.socrata.com/sites'))

def is_domain(potential_url):
    return '.' in potential_url and ' ' not in potential_url

# Make a directory for each portal.
for portal in portals:
    if is_domain(portal['description']):
        domain = portal['description']
    elif is_domain(portal['name']):
        domain = portal['name']
    elif portal['name'] == 'Socrata':
        continue
    else:
        warnings.warn('Could not find a valid domain for %s, skipping' % portal['name'])
        continue

    domain = domain.replace('https://', '').replace('http://', '')

    try:
        os.makedirs(os.path.join('data', domain))
    except OSError, e:
        if e.args[0] != 17:
            raise

