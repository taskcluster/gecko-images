FROM          registry.taskcluster.net/jonasfj/ubuntu
MAINTAINER    Jonas Finnemann Jensen <jopsen@gmail.com>


# Run system setup script
ADD           system-setup.sh   /tmp/system-setup.sh
RUN           ["/tmp/system-setup.sh"]
# Add utilities and configuration
ADD           mozconfigs/       /home/worker/mozconfigs/
ADD           build.sh          /home/worker/build.sh
ADD           worker-setup.sh   /tmp/worker-setup.sh

# Set variable normally configured at login, by the shells parent process, these
# are taken from GNU su manual
ENV           HOME          /home/worker
ENV           SHELL         /bin/bash
ENV           USER          worker
ENV           LOGNAME       worker

# Declare default user and default working folder
USER          worker
WORKDIR       /home/worker

# Run worker setup script
RUN           ["/tmp/worker-setup.sh"]

# Set a default command useful for debugging
CMD ["/bin/bash", "--login"]
