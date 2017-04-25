REPOSITORY ?= "cirros"
VERSION ?= "0.3.5"
IMAGE ?= $(REPOSITORY):$(VERSION)
RAM_CIRROS = "256"
SOCKETS_CIRROS = "1"
BRIDGES = "br-eth0 br-eth1 br-eth2 br-eth3 br-eth4 br-eth5 br-eth6 br-eth7 br-eth8 br-eth9 br-eth10 br-eth11"


BUILD_OPTIONS = -t $(IMAGE)
BUILD_OPTIONS += --build-arg CIRROS_VERSION=$(VERSION)
BUILD_OPTIONS += --build-arg BRIDGES=$(BRIDGES)


build:
	docker build $(BUILD_OPTIONS) .

clean:
	docker rmi $(IMAGE)
