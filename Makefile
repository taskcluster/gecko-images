
image:
	docker build -t jonasfj/gecko-builder .

clean:
	# Remove all docker containers:
	docker ps -a -q -notrunc | xargs docker rm

	# Remove all untagged images:
	docker images --no-trunc | grep ^\<none\> | awk '{print $3}' | xargs docker rmi


