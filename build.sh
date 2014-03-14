#!/bin/bash -live

################################### build.sh ###################################

### Check that we are running as worker
test `whoami` == 'worker';

### Check that require variables are defined
test $REPOSITORY  # Should be an hg repository url to pull from
test $REVISION    # Should be an hg revision to pull down
test $MOZCONFIG   # Should be a mozconfig file from mozconfig/ folder

### Pull, Update and Build
cd /home/worker/mozilla-central;
hg pull -r $REVISION $REPOSITORY;
hg update $REVISION;
./mach build;

### Make package
cd /home/worker/object-folder;
make package;

### Extract artifacts
# Navigate to dist/ folder
cd /home/worker/object-folder/dist;
# Discard version numbers from packaged files, they just make it hard to write
# the right filename in the task payload where artifacts are declared
mv firefox-*.tar.bz2  firefox.tar.bz2
mv firefox-*.json     firefox.json

################################### build.sh ###################################
