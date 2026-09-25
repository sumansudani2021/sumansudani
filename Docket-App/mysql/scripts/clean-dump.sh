#!/bin/sh
# Cleans a MySQL dump taken from another server so it imports without errors:
#   - DEFINER=`user`@`host`  -> DEFINER=CURRENT_USER   (avoids ERROR 1449 "definer does not exist")
#   - removes SET @@GLOBAL.GTID_PURGED ... statements  (avoids ERROR 3546 / GTID errors)
# Usage (inside the container):  sh /scripts/clean-dump.sh /dumps/dump.sql
#   -> writes /dumps/dump.clean.sql   (.sql.gz input is supported too)
set -e
in="$1"
[ -f "$in" ] || { echo "Usage: sh /scripts/clean-dump.sh /dumps/<file.sql|file.sql.gz>"; exit 1; }
case "$in" in
  *.gz) out="${in%.sql.gz}.clean.sql"; reader="gunzip -c" ;;
  *)    out="${in%.sql}.clean.sql";    reader="cat" ;;
esac
$reader "$in" \
  | sed -E 's/DEFINER=`[^`]+`@`[^`]+`/DEFINER=CURRENT_USER/g' \
  | sed '/@@GLOBAL.GTID_PURGED/{:a;/;/!{N;ba};d}' \
  > "$out"
echo "Cleaned dump written to $out"
