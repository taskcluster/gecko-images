REGISTRY ?= registry.taskcluster.net
INDEX		 ?= $(USER)
VERSION	 ?= latest
TARGET   	= $(REGISTRY)/$(INDEX)

B2G_EMULATOR_MOCHITEST_CHUNKS = 9
B2G_EMULATOR_CRASHTEST_CHUNKS = 3
B2G_EMULATOR_REFTEST_CHUNKS   = 20

TARGET_TASK = JpGcW5ykRRq73lmY1JKLZg

COMMON_RUN_OPTIONS = -e "TARGET_TASK=$(TARGET_TASK)"
# TODO: For local testing, I found this was handy...
COMMON_RUN_OPTIONS = -e "INSTALLER_URL=http://pvtbuilds.pvt.build.mozilla.org/pub/mozilla.org/b2g/try-builds/gbrown@mozilla.com-89c5bad2c328/try-emulator/emulator.tar.gz" -e "TEST_URL=http://pvtbuilds.pvt.build.mozilla.org/pub/mozilla.org/b2g/try-builds/gbrown@mozilla.com-89c5bad2c328/try-emulator/b2g-34.0a1.en-US.android-arm.tests.zip"
COMMON_RUN_OPTIONS += -ti $(TARGET)/gecko-tester:latest 

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

b2g-desktop-reftest:
	docker run \
	-e "TEST_SUITE=reftest" \
	$(COMMON_RUN_OPTIONS) ./b2g-desktop-tests.sh;

b2g-desktop-mochitest:
	docker run \
	-e "TEST_SUITE=mochitest" \
	$(COMMON_RUN_OPTIONS) ./b2g-desktop-tests.sh;

b2g-emulator-mochitest-1:
	docker run \
	-e "TEST_SUITE=mochitest" \
	-e "THIS_CHUNK=1" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_MOCHITEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-mochitest-2:
	docker run \
	-e "TEST_SUITE=mochitest" \
	-e "THIS_CHUNK=2" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_MOCHITEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-mochitest-3:
	docker run \
	-e "TEST_SUITE=mochitest" \
	-e "THIS_CHUNK=3" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_MOCHITEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-mochitest-4:
	docker run \
	-e "TEST_SUITE=mochitest" \
	-e "THIS_CHUNK=4" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_MOCHITEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-mochitest-5:
	docker run \
	-e "TEST_SUITE=mochitest" \
	-e "THIS_CHUNK=5" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_MOCHITEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-mochitest-6:
	docker run \
	-e "TEST_SUITE=mochitest" \
	-e "THIS_CHUNK=6" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_MOCHITEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-mochitest-7:
	docker run \
	-e "TEST_SUITE=mochitest" \
	-e "THIS_CHUNK=7" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_MOCHITEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-mochitest-8:
	docker run \
	-e "TEST_SUITE=mochitest" \
	-e "THIS_CHUNK=8" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_MOCHITEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-mochitest-9:
	docker run \
	-e "TEST_SUITE=mochitest" \
	-e "THIS_CHUNK=9" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_MOCHITEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-crashtest-1:
	docker run \
	-e "TEST_SUITE=crashtest" \
	-e "THIS_CHUNK=1" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_CRASHTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-crashtest-2:
	docker run \
	-e "TEST_SUITE=crashtest" \
	-e "THIS_CHUNK=2" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_CRASHTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-crashtest-3:
	docker run \
	-e "TEST_SUITE=crashtest" \
	-e "THIS_CHUNK=3" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_CRASHTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-reftest-1:
	docker run \
	-e "TEST_SUITE=reftest" \
	-e "THIS_CHUNK=1" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_REFTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-reftest-2:
	docker run \
	-e "TEST_SUITE=reftest" \
	-e "THIS_CHUNK=2" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_REFTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-reftest-3:
	docker run \
	-e "TEST_SUITE=reftest" \
	-e "THIS_CHUNK=3" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_REFTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-reftest-4:
	docker run \
	-e "TEST_SUITE=reftest" \
	-e "THIS_CHUNK=4" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_REFTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-reftest-5:
	docker run \
	-e "TEST_SUITE=reftest" \
	-e "THIS_CHUNK=5" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_REFTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-reftest-6:
	docker run \
	-e "TEST_SUITE=reftest" \
	-e "THIS_CHUNK=6" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_REFTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-reftest-7:
	docker run \
	-e "TEST_SUITE=reftest" \
	-e "THIS_CHUNK=7" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_REFTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-reftest-8:
	docker run \
	-e "TEST_SUITE=reftest" \
	-e "THIS_CHUNK=8" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_REFTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-reftest-9:
	docker run \
	-e "TEST_SUITE=reftest" \
	-e "THIS_CHUNK=9" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_REFTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-reftest-10:
	docker run \
	-e "TEST_SUITE=reftest" \
	-e "THIS_CHUNK=10" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_REFTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-reftest-11:
	docker run \
	-e "TEST_SUITE=reftest" \
	-e "THIS_CHUNK=11" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_REFTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-reftest-12:
	docker run \
	-e "TEST_SUITE=reftest" \
	-e "THIS_CHUNK=12" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_REFTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-reftest-13:
	docker run \
	-e "TEST_SUITE=reftest" \
	-e "THIS_CHUNK=13" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_REFTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-reftest-14:
	docker run \
	-e "TEST_SUITE=reftest" \
	-e "THIS_CHUNK=14" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_REFTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-reftest-15:
	docker run \
	-e "TEST_SUITE=reftest" \
	-e "THIS_CHUNK=15" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_REFTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-reftest-16:
	docker run \
	-e "TEST_SUITE=reftest" \
	-e "THIS_CHUNK=16" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_REFTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-reftest-17:
	docker run \
	-e "TEST_SUITE=reftest" \
	-e "THIS_CHUNK=17" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_REFTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-reftest-18:
	docker run \
	-e "TEST_SUITE=reftest" \
	-e "THIS_CHUNK=18" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_REFTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-reftest-19:
	docker run \
	-e "TEST_SUITE=reftest" \
	-e "THIS_CHUNK=19" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_REFTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-reftest-20:
	docker run \
	-e "TEST_SUITE=reftest" \
	-e "THIS_CHUNK=20" \
	-e "TOTAL_CHUNKS=$(B2G_EMULATOR_REFTEST_CHUNKS)" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

b2g-emulator-xpcshell:
	docker run \
	-e "TEST_SUITE=xpcshell" \
	-e "THIS_CHUNK=1" \
	-e "TOTAL_CHUNKS=1" \
	$(COMMON_RUN_OPTIONS) ./b2g-emulator-tests.sh

test-shell:
	docker run \
	-m "12g" \
	$(COMMON_RUN_OPTIONS) /bash;

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

