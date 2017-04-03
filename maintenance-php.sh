#!/bin/bash

# Redirect STDOUT to STDOUT (outside script)
exec 1>&1
# Redirect STDERR to STDERR (outside script)
exec 2>&2

CWD=$(dirname $(realpath $0))
APPDIR=$1
URL=$2
PHP_FPM_HOST=$3
PHP_FPM_PORT=$4

echo "APP DIR: $APPDIR"
echo "Moving to work tree directory: $APPDIR"

cd $APPDIR

echo "MAITENANCE TASKS"

# Echoes all commands before executing.
set -o verbose

# CLEAN OPCACHE
# https://github.com/gordalina/cachetool#usage-as-an-application

cachetool opcache:status --fcgi=$PHP_FPM_HOST:$PHP_FPM_PORT
cachetool opcache:reset --fcgi=$PHP_FPM_HOST:$PHP_FPM_PORT
cachetool opcache:status --fcgi=$PHP_FPM_HOST:$PHP_FPM_PORT

