FROM          ubuntu:13.10
MAINTAINER    Jonas Finnemann Jensen <jopsen@gmail.com>

# Run setup-script
ADD           setup.sh      /tmp/setup.sh
RUN           ["/tmp/setup.sh"]
# Add utilities and configuration
ADD           mozconfigs/   /home/worker/mozconfigs/
ADD           build.sh      /home/worker/build.sh

# Set variable normally configured at login, by the shells parent process, these
# are taken from GNU su manual
ENV           HOME          /home/worker
ENV           SHELL         /bin/bash
ENV           USER          worker
ENV           LOGNAME       worker

# Declare default user and default working folder
USER          worker
WORKDIR       /home/worker

# Set a default command useful for debugging
CMD ["/bin/bash", "--login"]
