#!/bin/bash -live

############################# b2g-desktop tests ############################

### Check that we are running as worker
test `whoami` == 'worker';

CONFIG_FILE=/home/worker/desktop_automation_config.py

# Fetch URLs for input binary and test zip file
#INSTALLER_URL=`./fetch-artifacts.py $TARGET_TASK -u target.linux-x86_64.tar.bz2`;
#TEST_URL=`./fetch-artifacts.py $TARGET_TASK -u target.tests.zip`;

# TODO: For local testing, remove this later
BUILD_ROOT=http://172.17.42.1/LocalB2G
INSTALLER_URL=$BUILD_ROOT/b2g-31.0a1.en-US.linux-x86_64.tar.bz2
TEST_URL=$BUILD_ROOT/b2g-31.0a1.en-US.linux-x86_64.tests.zip

# Run tests for b2g-desktop under xvfb
xvfb-run -s "-screen 0 800x1000x24" \
  python ./mozharness/scripts/b2g_desktop_unittest.py \
  --no-read-buildbot-config \
  --config-file /home/worker/b2g-desktop-config.py \
  --installer-url $INSTALLER_URL \
  --test-url $TEST_URL \
  --download-symbols ondemand \
  --test-suite $TEST_SUITE
############################# b2g-desktop tests ############################
