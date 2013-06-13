#!/usr/bin/env python2
import os
import lxml.html

DIR = os.path.join('data', os.environ['SOCRATA_URL'], 'searches')
OUTFILE = os.path.join('data', os.environ['SOCRATA_URL'], 'viewids')

def get_viewids():
    pages = filter(lambda page: set(page.split('-')[-1]).issubset(set('0123456789')), os.listdir(DIR))
    viewids = set()
    for page in pages:
        html = lxml.html.parse(os.path.join(DIR, page))
        viewids = viewids.union(parse(html))
    return viewids

def parse(html):
    'Get the viewids out.'
    return set(map(unicode, html.xpath('//tr[@itemtype="http://schema.org/Dataset"]/@data-viewid')))

if __name__ == '__main__':
    serialized = '\n'.join(get_viewids())
    open(OUTFILE, 'w').write(serialized)
