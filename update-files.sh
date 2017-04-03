#!/bin/bash

# Redirect STDOUT to STDOUT (outside script)
exec 1>&1
# Redirect STDERR to STDERR (outside script)
exec 2>&2

CWD=$(dirname $(realpath $0))

GITDIR=$1
APPDIR=$2
COMMIT=$3

echo "APP DIR: $APPDIR"
echo "GIT DIR: $GITDIR"
echo "Moving to work tree directory: $APPDIR"

cd $APPDIR

# Echoes all commands before executing.
set -o verbose

echo "UPDATE FILES"

# UPDATE REPOSITORY AND WORKWING COPY
git --git-dir=$GITDIR --work-tree=$APPDIR fetch --all
git --git-dir=$GITDIR --work-tree=$APPDIR reset --hard FETCH_HEAD
git --git-dir=$GITDIR --work-tree=$APPDIR clean -df
git --git-dir=$GITDIR --work-tree=$APPDIR checkout -f $COMMIT
git --git-dir=$GITDIR --work-tree=$APPDIR submodule sync
git --git-dir=$GITDIR --work-tree=$APPDIR submodule update --recursive --init
git --git-dir=$GITDIR --work-tree=$APPDIR gc --prune=all
git --git-dir=$GITDIR --work-tree=$APPDIR log -n 3
git --git-dir=$GITDIR --work-tree=$APPDIR status
