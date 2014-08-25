FROM          registry.taskcluster.net/mshal/gecko-base:latest
MAINTAINER    James Lal <jlal@mozilla.com>

# Many of these instructions are from:
# https://developer.mozilla.org/en-US/Firefox_OS/Firefox_OS_build_prerequisites#Have_a_compatible_device.2Femulator

# B2G (and emulators in particular have a ton of dependencies that most gecko
# builds do not necessarily need.... note that emulators require both 64 bit
# and 32 bit libs.
RUN dpkg --add-architecture i386; \
    apt-get update; \
    apt-get -y install \
      autoconf2.13 \
      bison \
      bzip2 \
      ccache \
      curl \
      flex \
      gawk \
      gcc \
      g++ \
      g++-multilib \
      gcc-4.6 \
      g++-4.6 \
      g++-4.6-multilib \
      git-core \
      lib32bz2-1.0 \
      lib32ncurses5-dev \
      lib32z1-dev \
      zlib1g:amd64 \
      zlib1g-dev:amd64 \
      zlib1g:i386 \
      zlib1g-dev:i386 \
      libgl1-mesa-dev \
      libx11-dev \
      make \
      cmake \
      libgl1-mesa-dev \
      libglapi-mesa:i386 \
      libgl1-mesa-glx:i386 \
      zip \
      openjdk-6-jdk;

# Terrible symlinking (required) so the 32bit versions are in the right spot for
# the emulator
RUN ln -s /usr/lib/i386-linux-gnu/libX11.so.6 /usr/lib/i386-linux-gnu/libX11.so; \
    ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 /usr/lib/i386-linux-gnu/libGL.so

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.6 1; \
 update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 2; \
 update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.6 1; \
 update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 2; \
 update-alternatives --set gcc "/usr/bin/gcc-4.6"; \
 update-alternatives --set g++ "/usr/bin/g++-4.6";

RUN pip install awscli

# primary harness script and build

# There are a few assumptions made by entrypoint as to the state of the slaves
# we _could_ run the pupet scripts here but for the b2g builds at least we can
# easily maintain the small number of deps here.
RUN mkdir -p $HOME/bin/; \
    REMOTE="https://github.com/mozilla/build-puppet/raw/master/modules/packages/files"; \
    cd $HOME/bin; \
    wget $REMOTE/gittool.py $REMOTE/hgtool.py $REMOTE/retry.py;

ADD bin/build /home/worker/bin/build
ADD .hgrc /home/worker/.hgrc

RUN chown -R worker:worker bin .hgrc; \
    chmod u+x bin/* .hgrc;

USER worker

ENV PATH /home/worker/bin:$PATH
ENV HG_SHARE_BASE_DIR /home/worker/checkouts
ENV CCACHE_DIR /home/worker/ccache
ENV CCACHE_COMPRESS 1
ENV CCACHE_UMASK 002
ADD build-setup.sh /tmp/build-setup.sh

RUN ["/tmp/build-setup.sh"]
