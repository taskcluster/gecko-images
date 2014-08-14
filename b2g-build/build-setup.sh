#!/bin/bash -ve

### B2G Build Setup

# This image never ever pushes to git but repo tool requires username and email
git config --global user.email "you@example.com"
git config --global user.name "Your Name"

# Clone B2G
git clone https://github.com/mozilla-b2g/B2G /home/worker/build

# Run config.sh to get .repo setup
cd /home/worker/build

wget http://hg.mozilla.org/mozilla-central/raw-file/default/b2g/config/emulator-ics/sources.xml
./config.sh emulator sources.xml

# Clone mozilla-central
hg clone https://hg.mozilla.org/mozilla-central/ /home/worker/checkouts/mozilla-central

# Setup the hg share
hg share /home/worker/checkouts/mozilla-central /home/worker/build/gecko

### Clean up from setup
# Remove the setup.sh setup, we don't really need this script anymore, deleting
# it keeps the image as clean as possible.
rm $0; echo "Deleted $0";
