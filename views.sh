#!/bin/sh
set -e

if test -z "$SOCRATA_URL"; then
  echo You need to set the SOCRATA_URL.
  exit 1
fi
DIR="data/$SOCRATA_URL/views"

mkdir -p "$DIR"
for viewid in $(cat "data/$SOCRATA_URL/viewids"); do
  test -e "$DIR/${viewid}" || wget --no-check-certificate -O "$DIR/${viewid}" "https://$SOCRATA_URL/views/${viewid}.json"
done
