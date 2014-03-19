TARGET = registry.taskcluster.net/jonasfj/gecko-builder

image:
	docker build -t $(TARGET) .

#/home/worker/mozconfigs/opt-firefox
#/home/worker/mozilla-central/b2g/config/mozconfigs/linux64_gecko/nightly
check:
	docker run \
	-e "MOZCONFIG=/home/worker/mozconfigs/b2g-desktop" \
	-e "REPOSITORY=https://hg.mozilla.org/mozilla-central/" \
	-e "REVISION=fe40387eba1a" \
	-ti \
	$(TARGET) ./build.sh;

clean:
	# Remove all docker containers:
	-docker ps -a -q -notrunc | xargs docker rm

	# Remove all untagged images:
	-docker images --no-trunc | grep ^\<none\> | awk '{print $3}' | xargs docker rmi


