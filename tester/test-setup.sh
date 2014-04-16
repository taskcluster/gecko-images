#!/bin/bash -ve

### Firefox Test Setup

# Install mozharness scripts
hg clone http://hg.mozilla.org/build/mozharness/

### Clean up from setup
# Remove the setup.sh setup, we don't really need this script anymore, deleting
# it keeps the image as clean as possible.
#rm $0; echo "Deleted $0";
