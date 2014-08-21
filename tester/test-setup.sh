#!/bin/bash -ve

### Firefox Test Setup

dpkg --add-architecture i386
apt-get update
apt-get install -y                \
        gcc-multilib              \
        g++-multilib              \
        libgl1-mesa-dri           \
        libgl1-mesa-glx:i386      \
        libglapi-mesa             \
        libglu1-mesa              \
        libncurses5:i386          \
        libsdl1.2debian:i386      \
        pulseaudio                \
        python-pip                \
        ;
pip install virtualenv;
mkdir Documents; mkdir Pictures; mkdir Music; mkdir Videos;
hg clone http://hg.mozilla.org/build/mozharness/
echo 'Xvfb :0 -nolisten tcp -screen 0 1600x1200x24 &> /dev/null &' >> .bashrc
chown -R worker:worker /home/worker/* /home/worker/.*

### Clean up from setup
# Remove the setup.sh setup, we don't really need this script anymore, deleting
# it keeps the image as clean as possible.
#rm $0; echo "Deleted $0";
