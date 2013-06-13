#!/bin/sh
set -e

for path in $(ls -d data/[a-z]*); do
  (
    export SOCRATA_URL=$(echo "$path" | cut -d/ -f2)
    echo $SOCRATA_URL
    ./run_one.sh
  )
done
