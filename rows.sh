#!/bin/sh
set -e

if test -z "$SOCRATA_URL"; then
  echo You need to set the SOCRATA_URL.
  exit 1
fi
DIR="data/$SOCRATA_URL/rows"

mkdir -p "$DIR"
for viewid in $(cat "data/$SOCRATA_URL/viewids"); do
  # Check for compressend and uncompressed versions of the file.
  test -e "$DIR/${viewid}.gz" || test -e "$DIR/${viewid}" ||
    wget -O "$DIR/${viewid}" "https://$SOCRATA_URL/api/views/${viewid}/rows.csv?accessType=DOWNLOAD"

  # Handle when I thrash the server.
  test -e "$DIR/${viewid}" &&
    grep '"message" : "You have exceeded the number of unregistered requests during the last hour. Please specify an app_token in your request"' "$DIR/${viewid}" &&
    rm "$DIR/${viewid}" && sleep 1h
  break
done
