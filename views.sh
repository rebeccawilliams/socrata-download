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
  if test -e "$DIR/${viewid}" || wget --no-check-certificate -O "$DIR/${viewid}" "https://$SOCRATA_URL/views/${viewid}.json" 2> $tmp; then continue

  # Skip on 404
  elif grep 'ERROR 404: Not Found.' $tmp; then continue

  # Wait on API limit.
  elif grep 'ERROR 429: 429' $tmp; then
    sleep 2h
    # Refactor this.
    wget --no-check-certificate -O "$DIR/${viewid}" "https://$SOCRATA_URL/views/${viewid}.json"

  fi 
done
