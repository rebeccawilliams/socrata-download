#!/bin/sh
set -e

if test -z "$SOCRATA_S3_BUCKET"; then
  echo You must specify a SOCRATA_S3_BUCKET
  exit 1
fi

# Gzip
find data/*/views|grep -v '\(\.gz\|\/views\)$'

# Upload
s3cmd sync \
  --skip-existing \
  --add-header='Content-Encoding:gzip' \
  --mime-type='application/json' \
  data "$SOCRATA_S3_BUCKET"
