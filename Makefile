REGISTRY	= registry.taskcluster.net
INDEX			= jonasfj
TARGET    = $(REGISTRY)/$(INDEX)

gecko-base:
	docker build -t $(TARGET)/gecko-base base/

gecko-builder:
	docker build -t $(TARGET)/gecko-builder builder/

gecko-tester:
	docker build -t $(TARGET)/gecko-tester tester/

#/home/worker/mozconfigs/opt-firefox
#/home/worker/mozilla-central/b2g/config/mozconfigs/linux64_gecko/nightly
check-builder:
	docker run \
	-e "MOZCONFIG=/home/worker/mozconfigs/b2g-desktop" \
	-e "REPOSITORY=https://hg.mozilla.org/mozilla-central/" \
	-e "REVISION=91be2828f17e" \
	-ti \
	$(TARGET)/gecko-builder:latest ./build.sh;

check-tester:
	docker run \
	-e "TARGET_TASK=M0rn4HDfTkuH31b1XnQS2Q" \
	-ti \
	$(TARGET)/gecko-tester:latest ./b2g-desktop-reftests.sh;

rmgarbage:
	# Remove all docker containers:
	-docker ps -a -q -notrunc | xargs docker rm
	-docker images --no-trunc | grep ^\<none\> | awk '{print $$3}' | xargs docker rmi

clean:
	# Remove all docker containers:
	-docker ps -a -q -notrunc | xargs docker rm

	# Remove all untagged images:
	-docker images --no-trunc | awk '{print $$3}' | xargs docker rmi


