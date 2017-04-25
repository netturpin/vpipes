REPOSITORY ?= "bsdrp"
VERSION ?= "1.902"
IMAGE ?= $(REPOSITORY):$(VERSION)
RAM_CIRROS = "256"
SOCKETS_CIRROS = "1"
BRIDGES = "br-em0 br-em1 br-em2 br-em3 br-em4 br-em5 br-em6 br-em7 br-em8 br-em9 br-em10 br-em11"


BUILD_OPTIONS = -t $(IMAGE)
BUILD_OPTIONS += --build-arg BSDRP_VERSION=$(VERSION)
BUILD_OPTIONS += --build-arg BRIDGES=$(BRIDGES)


build:
	docker build $(BUILD_OPTIONS) .

clean:
	docker rmi $(IMAGE)
