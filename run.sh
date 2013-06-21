#!/bin/sh
set -e

# Remove bad portals.
rm -fR data/{consumerfinance.gov,datakc.org,data.undp.com,ethics.gov,dati.wa.gov,metrochicagodata.com,nyc.gov,bronx.lehman.cuny.edu}

# Something's weird about this one.
rm -fR data/data.act.gov.au

# Add portals that aren't listed on the Socrata site.
mkdir -p data/{data.cityofnewyork.us,opendata.socrata.com}

# Download good portals.
for path in $(ls -d data/[a-z]*); do
  (
    export SOCRATA_URL=$(echo "$path" | cut -d/ -f2)
    echo $SOCRATA_URL
    if ! ./run_one.sh; then
      echo 'I hit an API limit and am waiting two hours.'
      sleep 2h
      continue
    fi
  )
  echo
done

./s3-upload.sh
