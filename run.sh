#!/bin/sh
set -e

# Get portals from the website.
./portals.py

# Fix bad portals.
fix() {
  if test -d "data/$2"; then
    rmdir "data/$1"
  else
    mv "data/$1" "data/$2"
  fi
}

fix consumerfinance.gov data.consumerfinance.gov
fix data.act.gov.au www.data.act.gov.au
fix www.datakc.org data.kingcounty.gov

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
