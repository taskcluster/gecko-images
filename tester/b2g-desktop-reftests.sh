#!/bin/bash -live

############################# b2g-desktop reftests ############################

### Check that we are running as worker
test `whoami` == 'worker';

# Fetch URLs for input binary and test zip file
BUILD_URL=`./fetch-artifacts.py $TARGET_TASK -u target.linux-x86_64.tar.bz2`;
TESTS_URL=`./fetch-artifacts.py $TARGET_TASK -u target.tests.zip`;

# Run reftests for b2g-desktop under xvfb
xvfb-run -s "-screen 0 800x1000x24" \
  python ./mozharness/scripts/b2g_desktop_unittest.py \
  --installer-url $BUILD_URL \
  --test-url $TESTS_URL \
  --test-suite reftest \
  --download-symbols ondemand \
  --cfg b2g-desktop-config.py \
  --no-read-buildbot-config \
  --test-manifest tests/layout/reftests/reftest-sanity/reftest.list \
  ;

############################# b2g-desktop reftests ############################
