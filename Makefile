REGISTRY ?= registry.taskcluster.net
INDEX		 ?= $(USER)
VERSION	 ?= latest
TARGET   	= $(REGISTRY)/$(INDEX)


gecko-base:
	docker build -t $(TARGET)/gecko-base:$(VERSION) base/

gecko-builder:
	docker build -t $(TARGET)/gecko-builder:$(VERSION) builder/

gecko-tester:
	docker build -t $(TARGET)/gecko-tester:$(VERSION) tester/

#/home/worker/mozconfigs/opt-firefox
#/home/worker/mozilla-central/b2g/config/mozconfigs/linux64_gecko/nightly
check-builder:
	docker run \
	-e "MOZCONFIG=/home/worker/mozconfigs/b2g-desktop" \
	-e "REPOSITORY=https://hg.mozilla.org/mozilla-central/" \
	-e "REVISION=68c042c2b2e5" \
	-ti \
	$(TARGET)/gecko-builder:$(VERSION) ./build-b2g-desktop.sh;

check-tester:
	docker run \
	-e "TARGET_TASK=ZX_pn0EvTIqlsE9Zzn4EIA" \
	-ti \
	$(TARGET)/gecko-tester:$(VERSION) ./b2g-desktop-reftests.sh;

rmgarbage:
	# Remove all docker containers:
	-docker ps -a -q -notrunc | xargs docker rm
	-docker images --no-trunc | grep ^\<none\> | awk '{print $$3}' | xargs docker rmi

clean:
	# Remove all docker containers:
	-docker ps -a -q -notrunc | xargs docker rm

	# Remove all untagged images:
	-docker images --no-trunc | awk '{print $$3}' | xargs docker rmi

publish:
	docker push \
		$(TARGET)/gecko-builder \
		$(TARGET)/gecko-tester

