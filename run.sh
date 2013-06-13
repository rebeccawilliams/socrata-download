#!/bin/sh
set -e

# Remove bad portals.
rm -fR data/{consumerfinance.gov,datakc.org,data.undp.com,ethics.gov,dati.wa.gov,metrochicagodata.com,nyc.gov,bronx.lehman.cuny.edu}

# Download good portals.
for path in $(ls -d data/[a-z]*); do
  (
    export SOCRATA_URL=$(echo "$path" | cut -d/ -f2)
    echo $SOCRATA_URL
    ./run_one.sh
  )
done
