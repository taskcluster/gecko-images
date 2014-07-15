REGISTRY ?= registry.taskcluster.net
INDEX		 ?= $(USER)
VERSION	 ?= latest
TARGET   	= $(REGISTRY)/$(INDEX)

TARGET_TASK = JpGcW5ykRRq73lmY1JKLZg

gecko-base:
	docker build -t $(TARGET)/gecko-base:$(VERSION) base/

gecko-builder:
	docker build -t $(TARGET)/gecko-builder:$(VERSION) builder/

gecko-tester:
	docker build -t $(TARGET)/gecko-tester:$(VERSION) tester/

check-builder:
	docker run \
	-e "MOZCONFIG=/home/worker/mozconfigs/b2g-desktop" \
	-e "REPOSITORY=https://hg.mozilla.org/mozilla-central/" \
	-e "REVISION=68c042c2b2e5" \
	-ti \
	$(TARGET)/gecko-builder:$(VERSION) ./build-b2g-desktop.sh;

check-reftest:
	docker run \
	-e "TARGET_TASK=$(TARGET_TASK)" \
	-e "TEST_SUITE=reftest" \
	-ti \
	$(TARGET)/gecko-tester:latest ./b2g-desktop-tests.sh;

check-mochitest:
	docker run \
	-e "TARGET_TASK=$(TARGET_TASK)" \
	-e "TEST_SUITE=mochitest" \
	-ti \
	$(TARGET)/gecko-tester:latest ./b2g-desktop-tests.sh;

test-shell:
	docker run \
	-e "TARGET_TASK=$(TARGET_TASK)" \
	-e "TEST_SUITE=mochitest" \
	-ti \
	-m "12g" \
	$(TARGET)/gecko-tester:latest /bin/bash;


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
	docker push $(TARGET)/gecko-builder;
	docker push $(TARGET)/gecko-tester;

