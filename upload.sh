#!/bin/sh
set -e

if test -z "$SOCRATA_S3_BUCKET"; then
  echo You must specify a SOCRATA_S3_BUCKET
  exit 1
fi

# Gzip
if find data/*/views|grep -v '\(\.gz\|\/views\)$' > /tmp/to_gzip; then
  cat /tmp/to_gzip | xargs gzip
fi

# Upload
(
  cd data
  for portal in $(ls); do
    cd $portal
    s3cmd sync \
      --skip-existing \
      --add-header='Content-Encoding:gzip' \
      --mime-type='application/json' \
      views "$SOCRATA_S3_BUCKET/$portal/"
  done
)
