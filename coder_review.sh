#!/bin/bash

# Whatever happens, we really need drush
which drush >/dev/null 2>&1
if [ "$?" == "1" ]; then
  echo "Drush not installed."
  exit 1
fi

# To use coder, we have to be in the directory containing the file.
cd `dirname $1`

has_coder=$(drush | grep coder-review | wc -l)
if [ "$has_coder" == "0" ]; then
  echo "Coder not installed or not enabled on this build."
  exit 2
fi

# Find this file relative to the build
root=$(drush status | grep "Drupal root" | awk -F: '{ print $2 }')
file=$(echo $1 | sed -e "s!$root/!!")

# Can run coder-review without sniffer if we have to...
sniffer_flag=""
which phpcs >/dev/null 2>&1
if [ "$?" == "0" ]; then
  sniffer_flag=--sniffer
fi

# Now run it on the file!
~/.vimrc.d/personal/coder_review_command.sh "$file" "$sniffer_flag"
