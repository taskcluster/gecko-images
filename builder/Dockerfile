FROM          registry.taskcluster.net/jonasfj/gecko-base
MAINTAINER    Jonas Finnemann Jensen <jopsen@gmail.com>

# Add utilities and configuration
ADD           mozconfigs/           /home/worker/mozconfigs/
ADD           build.sh              /home/worker/build.sh
ADD           build-b2g-desktop.sh  /home/worker/build-b2g-desktop.sh
ADD           get_gaia_repo.js      /home/worker/get_gaia_repo.js
ADD           get_gaia_revision.js  /home/worker/get_gaia_revision.js
ADD           build-setup.sh        /tmp/build-setup.sh

# Run build setup script
RUN           ["/tmp/build-setup.sh"]

# Set a default command useful for debugging
CMD ["/bin/bash", "--login"]
