#!/bin/sh
set -e

if test -z "$SOCRATA_URL"; then
  echo You need to set the SOCRATA_URL.
  exit 1
fi

download_page() {
  [ -z "$1" ] && echo 'You must specify a page number' && return 1
  file="data/$SOCRATA_URL/searches/$1"
  test -f "$file" || wget -O "$file" "https://$SOCRATA_URL/browse?utf8=?&page=$1"

  # Error on the last page because the last page does not say 'title="last page"'.
  grep 'title="Last Page"' "$file" > /dev/null
}

mkdir -p "data/$SOCRATA_URL/searches"
page=1
while true; do
  download_page $page || break
  page=$(($page + 1))
done
