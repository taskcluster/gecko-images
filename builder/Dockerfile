FROM          registry.taskcluster.net/jonasfj/gecko-base
MAINTAINER    Jonas Finnemann Jensen <jopsen@gmail.com>

# Add utilities and configuration
ADD           mozconfigs/       /home/worker/mozconfigs/
ADD           build.sh          /home/worker/build.sh
ADD           build-setup.sh    /tmp/build-setup.sh

# Run build setup script
RUN           ["/tmp/build-setup.sh"]

# Set a default command useful for debugging
CMD ["/bin/bash", "--login"]
