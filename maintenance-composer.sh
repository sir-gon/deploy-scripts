#!/bin/bash

# Redirect STDOUT to STDOUT (outside script)
exec 1>&1
# Redirect STDERR to STDERR (outside script)
exec 2>&2

CWD=$(dirname $(realpath $0))
APPDIR=$1

echo "COMPOSER MAITENANCE TASKS"

# Echoes all commands before executing.
set -o verbose

cd $APPDIR
composer install
