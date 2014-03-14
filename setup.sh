#!/bin/bash -ve

################################### setup.sh ###################################

### Check that we are running as root
test `whoami` == 'root';

### Add worker user
# Minimize the number of things which the build script can do, security-wise
# it's not a problem to let the build script install things with apt-get. But it
# really shouldn't do this, so let's forbid root access.
useradd -d /home/worker -s /bin/bash -m worker;

### Install Useful Packages
# First we update and upgrade to latest versions.
apt-get update;
apt-get upgrade -y;

# Let's install some goodies, ca-certificates is needed for https with hg.
# sudo will be required anyway, but let's make it explicit. It nice to have
# sudo around. We'll also install nano, this is pure bloat I know, but it's
# useful a text editor.
apt-get install -y                  \
  ca-certificates                   \
  sudo                              \
  nano                              \
  ;

# Then let's install all firefox build dependencies, this are extracted from
# mozboot. See python/mozboot/bin/bootstrap.py in mozilla-central.
apt-get install -y                  \
  autoconf2.13                      \
  build-essential                   \
  ccache                            \
  libasound2-dev                    \
  libcurl4-openssl-dev              \
  libdbus-1-dev                     \
  libdbus-glib-1-dev                \
  libgconf2-dev                     \
  libgstreamer0.10-dev              \
  libgstreamer-plugins-base0.10-dev \
  libgtk2.0-dev                     \
  libiw-dev                         \
  libnotify-dev                     \
  libpulse-dev                      \
  libxt-dev                         \
  mercurial                         \
  mesa-common-dev                   \
  python-dev                        \
  unzip                             \
  uuid                              \
  yasm                              \
  xvfb                              \
  zip                               \
  software-properties-common        \
  ;

### Ubuntu 13.10 Configuration
# For some reason /etc/mercurial/hgrc.d/cacerts.rc is missing from the amd64
# mercurial package on ubuntu 13.10, a bug as been reported, see: 
# https://bugs.launchpad.net/ubuntu/+source/mercurial/+bug/1292231
# Until resolved the following workaround should do the trick.
#
# Note, this a 13.10 specific bug, debian unstable and 14.04 does not suffer
# from this issue, as files have moved to mercurial-common.
echo -e '[web]\ncacerts = /etc/ssl/certs/ca-certificates.crt' \
         > /etc/mercurial/hgrc.d/cacerts.rc;

### Firefox Build Setup
# Clone mozilla-central
sudo -u worker hg clone https://hg.mozilla.org/mozilla-central/               \
                        /home/worker/mozilla-central/
# Create .mozbuild so mach doesn't complain about this
sudo -u worker mkdir /home/worker/.mozbuild/
# Create object-folder exists
sudo -u worker mkdir /home/worker/object-folder/

### Clean up from setup
# Remove cached .deb packages. Cached package takes up a lot of space and
# distributing them to workers is wasteful.
apt-get clean;

# Remove the setup.sh setup, we don't really need this script anymore, deleting
# it keeps the image as clean as possible.
rm $0; echo "Deleted $0";

################################### setup.sh ###################################
