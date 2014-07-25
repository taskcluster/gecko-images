FROM          registry.taskcluster.net/jonasfj/gecko-base
MAINTAINER    Jonas Finnemann Jensen <jopsen@gmail.com>

# Add utilities and configuration
ADD           fetch-artifacts.py            /home/worker/fetch-artifacts.py
ADD           b2g-desktop-tests.sh          /home/worker/b2g-desktop-tests.sh
ADD           b2g-desktop-config.py         /home/worker/b2g-desktop-config.py
ADD           emulator_automation_config.py /home/worker/emulator_automation_config.py
ADD           dot-config                    /home/worker/.config

# Install additional libs required by adb and emulator
USER          root
RUN           dpkg --add-architecture i386
RUN           apt-get update
RUN           apt-get install -y                \
              gcc-multilib                      \
              g++-multilib                      \
              libgl1-mesa-dri                   \
              libgl1-mesa-glx:i386              \
              libglapi-mesa                     \
              libglu1-mesa                      \
              libncurses5:i386                  \
              libsdl1.2debian:i386              \
              ;
RUN           chown worker * .*
RUN           chgrp worker * .*

USER          worker
RUN           mkdir Documents; mkdir Pictures; mkdir Music; mkdir Videos;
RUN           hg clone http://hg.mozilla.org/build/mozharness/
RUN           echo 'Xvfb :0 -nolisten tcp -screen 0 1600x1200x24 &> /dev/null &' >> .bashrc

ENV           DISPLAY         :0

# Set a default command useful for debugging
CMD ["/bin/bash", "--login"]
