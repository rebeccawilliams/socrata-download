#!/bin/sh
set -e

if test -z "$SOCRATA_S3_BUCKET"; then
  echo You must specify a SOCRATA_S3_BUCKET
  exit 1
fi

if test -e data; then
  echo The file or directory \"data\" already exists.
  echo You must remove it if you want to download data.
  echo "For now, I'm just uncompressing any gzipped"
  echo files in data.
else
  echo Downloading from S3
  s3cmd sync "$SOCRATA_S3_BUCKET" data
fi

# Gunzip
find data -name *.gz -exec gunzip --verbose {} \;
