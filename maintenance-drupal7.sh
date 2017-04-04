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

# Echoes all commands before executing.
set -o verbose

echo "MAITENANCE TASKS"

# CLEAN PHP OPCACHE
# https://github.com/gordalina/cachetool#usage-as-an-application
echo "CLEAN PHP OPCACHE"
cachetool opcache:status --fcgi=$PHP_FPM_HOST:$PHP_FPM_PORT
cachetool opcache:reset --fcgi=$PHP_FPM_HOST:$PHP_FPM_PORT
cachetool opcache:status --fcgi=$PHP_FPM_HOST:$PHP_FPM_PORT

# APPLY CODE AND DATABASE UPDATES
echo "APPLY CODE AND DATABASE UPDATES"
drush -l $URL --root=$APPDIR/html -yv rr
drush -l $URL --root=$APPDIR/html -yv cc all
drush -l $URL --root=$APPDIR/html -yv updb

# INTEGRATE TRANSLATIONS
drush -l $URL --root=$APPDIR/html -yv pm-enable potx_exportables
drush -l $URL --root=$APPDIR/html -yv potx-import-all
drush -l $URL --root=$APPDIR/html -yv pm-disable potx_exportables

# UPDATE TRANSLATIONS

