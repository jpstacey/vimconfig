#!/bin/bash

# Split regex file using newlines only.
old_ifs="$IFS"
IFS="
"

# Loop over file of regexes.
if [[ ! -f "$1" ]]; then
  echo "Use $1 to store a blacklist of file regexes."
  exit 2
fi
for regex in `cat "$1"`; do
  # Match each one against the incoming filename.
  if [[ $2 =~ $regex ]]; then
    echo $regex
    exit 1
  fi
done

# Instigate old Internal Field Separator.
IFS="$old_ifs"
