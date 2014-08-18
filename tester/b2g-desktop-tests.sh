#!/bin/bash -live

############################# b2g-desktop tests ############################

### Check that we are running as worker
test `whoami` == 'worker';

# Determine URLs for input binary and test zip file
if [ -z $INSTALLER_URL ] 
then
  if [ -z $TARGET_TASK ]
  then
    # TODO: For local testing, remove this later
    BUILD_ROOT=http://172.17.42.1/LocalB2G
    INSTALLER_URL=$BUILD_ROOT/b2g-34.0a1.en-US.linux-x86_64.tar.bz2
    TEST_URL=$BUILD_ROOT/b2g-34.0a1.en-US.linux-x86_64.tests.zip
  else
    INSTALLER_URL=`./fetch-artifacts.py $TARGET_TASK -u target.linux-x86_64.tar.bz2`;
    TEST_URL=`./fetch-artifacts.py $TARGET_TASK -u target.tests.zip`;
  fi
fi

# For reftests, use manifest to restrict to sanity tests only
if [ "$TEST_SUITE" == "reftest" ]
then
  EXTRA="--test-manifest tests/layout/reftests/reftest-sanity/reftest.list"
fi

# Run tests for b2g-desktop
python ./mozharness/scripts/b2g_desktop_unittest.py \
  --no-read-buildbot-config \
  --config-file /home/worker/b2g-desktop-config.py \
  --installer-url $INSTALLER_URL \
  --test-url $TEST_URL \
  --download-symbols ondemand \
  --test-suite $TEST_SUITE \
  $EXTRA

############################# b2g-desktop tests ############################
