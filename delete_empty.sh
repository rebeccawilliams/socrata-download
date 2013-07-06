#!/bin/sh

find data -wholename '*views/*' -type f -exec ./util/delete_empty_one.sh {} \;
