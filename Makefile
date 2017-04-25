DOCKER_OPTS = -H tcp://127.0.0.1:2375

cables:

consul:
	docker inspect consul > /dev/null 2>&1 || \
	docker run -d --rm -p 8500:8500 --name consul --net vpipes consul:0.8.1 agent -dev -server -datacenter=vpipes -client=0.0.0.0 -ui && \
	echo "Consul container is running"

tf-files: 
	scripts/build-kv.py lab.json > tf/vpipes.tf

plan:
	./scripts/build-kv.py lab.json > tf/vpipes.tf
	docker run -v ${PWD}/tf:/tf -v /var/run/docker.sock:/var/run/docker.sock --rm --net host --workdir /tf -it hashicorp/terraform:light plan

apply:
	./scripts/build-kv.py lab.json > tf/vpipes.tf
	docker run -v ${PWD}/tf:/tf -v /var/run/docker.sock:/var/run/docker.sock --rm --net host --workdir /tf -it hashicorp/terraform:light apply
	for i in $$(jq -r '.devices[] | .name' lab.json); do docker network disconnect bridge $$i; done

destroy:
	docker run -v ${PWD}/tf:/tf -v /var/run/docker.sock:/var/run/docker.sock --rm --net host --workdir /tf -it hashicorp/terraform:light destroy

pull:
	docker pull hashicorp/terraform:light
	docker pull progrium/consul:latest

check:
	# Check nested virt capabilities
	# Make docker listen on tcp and unix socket DOCKER_OPTS="-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock"
	docker -H tcp://127.0.0.1:2375 ps
	docker inspect $$(jq -r ".devices[].image" lab.json | sort -u) &>/dev/null || echo "Not all images found in local registry"
	docker network inspect vpipes
clean: destroy
	rm -Rf tf/*
	docker rm -f consul
