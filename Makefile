
mozilla-central.hg:
	wget http://ftp.mozilla.org/pub/mozilla.org/firefox/bundles/mozilla-central.hg

image: mozilla-central.hg
	docker build -t jonasfj/gecko-builder .

check:
	docker run \
	-e "MOZCONFIG=/home/worker/mozconfigs/opt-firefox" \
	-e "REPOSITORY=https://hg.mozilla.org/mozilla-central/" \
	-e "REVISION=fe40387eba1a" \
	-ti \
	jonasfj/gecko-builder ./build.sh;

clean:
	# Remove all docker containers:
	-docker ps -a -q -notrunc | xargs docker rm

	# Remove all untagged images:
	-docker images --no-trunc | grep ^\<none\> | awk '{print $3}' | xargs docker rmi


