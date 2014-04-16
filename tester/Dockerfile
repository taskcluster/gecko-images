FROM          registry.taskcluster.net/jonasfj/gecko-base
MAINTAINER    Jonas Finnemann Jensen <jopsen@gmail.com>

# Add utilities and configuration
ADD           fetch-artifacts.py        /home/worker/fetch-artifacts.py
ADD           b2g-desktop-tests.sh      /home/worker/b2g-desktop-tests.sh
ADD           b2g-desktop-config.py     /home/worker/b2g-desktop-config.py
ADD           test-setup.sh             /tmp/test-setup.sh

# Run test setup script
RUN           ["/tmp/test-setup.sh"]

# Set a default command useful for debugging
CMD ["/bin/bash", "--login"]
