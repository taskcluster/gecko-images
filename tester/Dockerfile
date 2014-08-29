FROM          quay.io/mozilla/gecko-base
MAINTAINER    Jonas Finnemann Jensen <jopsen@gmail.com>

# Add utilities and configuration
ADD           fetch-artifacts.py            /home/worker/fetch-artifacts.py
ADD           b2g-desktop-tests.sh          /home/worker/b2g-desktop-tests.sh
ADD           b2g-emulator-tests.sh         /home/worker/b2g-emulator-tests.sh
ADD           b2g-desktop-config.py         /home/worker/b2g-desktop-config.py
ADD           test-setup.sh                 /tmp/test-setup.sh
ADD           dot-config                    /home/worker/.config
ADD           emulator_automation_config.py /home/worker/emulator_automation_config.py

ENV           DISPLAY         :0

# Run test setup script
USER          root
RUN           ["/tmp/test-setup.sh"]

USER          worker

# Set a default command useful for debugging
CMD ["/bin/bash", "--login"]
