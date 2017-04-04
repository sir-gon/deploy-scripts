#!/bin/bash

# Redirect STDOUT to STDOUT (outside script)
exec 1>&1
# Redirect STDERR to STDERR (outside script)
exec 2>&2

APPDIR=$1

echo "APP DIR: $APPDIR"
echo "Moving to work tree directory: $APPDIR"

cd $APPDIR

# Echoes all commands before executing.
set -o verbose

# Maintenance tasks
yarn install --save --verbose --mutex file
yarn build --mutex file

