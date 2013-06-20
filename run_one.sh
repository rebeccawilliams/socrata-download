#!/bin/sh
set -e

if test -z "$SOCRATA_URL"; then
  echo You need to set the SOCRATA_URL.
  exit 1
fi

if test -f "data/$SOCRATA_URL/viewids"; then
  echo There is already a viewids file, so
  echo I am jumping to downloading metadata.
else
  echo Searching for dataset identifiers
  ./search.sh
  ./viewids.py
fi
./views.sh
# ./rows.sh
# ./builddb.py
