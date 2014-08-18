#!/bin/bash -live

### Check that we are running as worker
test `whoami` == 'worker';

# Determine URLs for input binary and test zip file
if [ -z $INSTALLER_URL ]
then
  if [ -z $TARGET_TASK ]
  then
    # TODO: For local testing, remove this later
    BUILD_ROOT=http://172.17.42.1/LocalB2G
    INSTALLER_URL=$BUILD_ROOT/emulator.tar.gz
    TEST_URL=$BUILD_ROOT/b2g-34.0a1.en-US.android-arm.tests.zip
  else
    INSTALLER_URL=`./fetch-artifacts.py $TARGET_TASK -u emulator.tar.gz`;
    TEST_URL=`./fetch-artifacts.py $TARGET_TASK -u target.tests.zip`;
  fi
fi

# Run tests for b2g-emulator
python ./mozharness/scripts/b2g_emulator_unittest.py \
  --no-read-buildbot-config \
  --cfg /home/worker/emulator_automation_config.py \
  --download-symbols ondemand \
  --installer-url $INSTALLER_URL \
  --test-url $TEST_URL \
  --test-suite $TEST_SUITE \
  --this-chunk $THIS_CHUNK \
  --total-chunks $TOTAL_CHUNKS
