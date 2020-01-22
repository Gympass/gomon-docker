#!/bin/sh

timestmp() {
    date +'[%F %T] [gomon] '
}

inotifywait -e MODIFY -e DELETE -q -r -m /app 2>/dev/null |
  while read -r path action file; do
    ext="${file##*.}"
    if [ "${ext}" != "go" ]; then
      continue
    fi
    echo "$(timestmp)${action}-ed ${file}"
    kill -s USR1 1 &
  done
