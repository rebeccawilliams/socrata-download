#!/bin/sh
set -e

if test -z "$SOCRATA_S3_BUCKET"; then
  echo You must specify a SOCRATA_S3_BUCKET
  exit 1
fi

if test -e data; then
  echo The file or directory \"data\" already exists.
  echo You must remove this so that I can create it.
fi

s3cmd sync "$SOCRATA_S3_BUCKET" data

# Gunzip
find data -name *.gz -exec gunzip {} \;
