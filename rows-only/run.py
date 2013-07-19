import os

for portal in os.listdir('data'):
    for viewid in open(os.path.join('data', portal, 'viewids')).readlines():
        print portal, viewid
    break
