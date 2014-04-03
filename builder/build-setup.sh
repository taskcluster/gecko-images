#!/bin/bash -ve

### Firefox Build Setup
# Clone mozilla-central
hg clone https://hg.mozilla.org/mozilla-central/ /home/worker/mozilla-central/

# Create .mozbuild so mach doesn't complain about this
mkdir /home/worker/.mozbuild/

# Create object-folder exists
mkdir /home/worker/object-folder/

### Clean up from setup
# Remove the setup.sh setup, we don't really need this script anymore, deleting
# it keeps the image as clean as possible.
rm $0; echo "Deleted $0";