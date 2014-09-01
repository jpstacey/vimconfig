#!/bin/bash

# Our current directory.
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Whatever happens, we really need drush
which drush >/dev/null 2>&1
if [ "$?" == "1" ]; then
  echo "Drush not installed."
  exit 1
fi

# Blacklist of files to ignore: run first (quicker than drush).
match=$("$dir/blacklist_with_regexes.sh" ~/.coder.review.blacklist "$1")
if [ "$?" == "1" ]; then
  echo "Coder review skipped: filename matches a blacklist regex"
  echo "Regex details: $match"
  exit 2
fi

# To use coder, we have to be in the directory containing the file.
cd `dirname $1`

has_coder=$(drush | grep coder-review | wc -l)
if [ "$has_coder" == "0" ]; then
  echo "Coder not installed or not enabled on this build."
  exit 3
fi

# Find this file relative to the build
root=$(drush dd root)
file=$(echo $1 | sed -e "s^$root/^^")

# Can run coder-review without sniffer if we have to...
sniffer_flag=""
which phpcs >/dev/null 2>&1
if [ "$?" == "0" ]; then
  sniffer_flag=--sniffer
fi

# Now run it on the file!
"$dir/coder_review_command.sh" "$file" "$sniffer_flag"
