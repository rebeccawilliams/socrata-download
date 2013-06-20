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
    (
      cd $portal
      s3cmd sync \
        --skip-existing \
        --add-header='Content-Encoding:gzip' \
        --mime-type='application/json' \
        views "$SOCRATA_S3_BUCKET/$portal/"
    )
  done
)

# Warning
echo The data have been uploaded.
echo 
echo As a side effect of this, the data directory is now
echo in a state that the rest of the Socrata downloader
echo tools cannot use.
echo
echo In order to download more data, you must run the
echo S3 download script. It will skip the files that are
echo already downloaded and uncompress all of the files
echo so that the rest of the Socrata downloader tools work.
