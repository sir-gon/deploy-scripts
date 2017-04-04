#!/bin/bash

# Redirect STDOUT to STDOUT (outside script)
exec 1>&1
# Redirect STDERR to STDERR (outside script)
exec 2>&2

CWD=$(dirname $(realpath $0))

APPDIR=$(realpath $CWD/../../app)
GITDIR=$(realpath $CWD/../../app.git)

echo "APP DIR: $APPDIR"
echo "Moving to work tree directory: $APPDIR"

cd $APPDIR

# Echoes all commands before executing.
set -o verbose

# Maintenance tasks
yarn install --save --verbose
yarn build

