#!/bin/sh
set -e

# Get portals from the website.
./portals.py

# Fix bad portals.
if test -d data/data.consumerfinance.gov; then
  rmdir data/consumerfinance.gov
else
  mv data/consumerfinance.gov data/data.consumerfinance.gov
fi

# Something's weird about this one.
rm -fR data/data.act.gov.au

# Add portals that aren't listed on the Socrata site.
mkdir -p data/opendata.socrata.com

# Download good portals.
for path in $(ls -d data/[a-z]*); do
  (
    export SOCRATA_URL=$(echo "$path" | cut -d/ -f2)
    echo $SOCRATA_URL
    ./run_one.sh >> /tmp/$SOCRATA_URL.log &
  )
  echo
done
