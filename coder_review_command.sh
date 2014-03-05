#!/bin/bash

# Run coder-review with standard arguments
drush coder-review $1 \
  --comment --minor --sql --style $2 \
  2>&1 | grep -v "No Problems Found" | grep -v '^$'
