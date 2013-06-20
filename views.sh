#!/bin/sh
set -e

if test -z "$SOCRATA_URL"; then
  echo You need to set the SOCRATA_URL.
  exit 1
fi
DIR="data/$SOCRATA_URL/views"

tmp=$(mktemp)
mkdir -p "$DIR"
echo $tmp
for viewid in $(cat "data/$SOCRATA_URL/viewids"); do

  if test -e "$DIR/${viewid}" || wget --no-check-certificate -O "$DIR/${viewid}" "https://$SOCRATA_URL/views/${viewid}.json" 2> $tmp; then
    # Sleep if it worked
    sleep 1s
    continue

  elif grep 'ERROR 404: Not Found.' $tmp; then
    # Skip on 404, after sleeping
    sleep 1s
    continue

  elif grep 'ERROR 429: 429' $tmp; then
    # Die on API limit, with a note to try later.
    echo "You've hit an API limit. Try again later. Bye."
    break

  fi 
done
