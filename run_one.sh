#!/bin/sh
set -e

if test -z "$SOCRATA_URL"; then
  echo You need to set the SOCRATA_URL.
  exit 1
fi

./search.sh
./viewids.py
./views.sh
# ./rows.sh
# ./builddb.py
