FROM golang:alpine
MAINTAINER "HashiCorp Terraform Team <terraform@hashicorp.com>"

ENV TERRAFORM_VERSION=0-8-bridge-issue

RUN apk add --update git bash

ENV TF_DEV=true

WORKDIR $GOPATH/src/github.com/hashicorp/terraform
RUN git clone https://github.com/fdebonneval/terraform.git ./ && \
    git checkout ${TERRAFORM_VERSION} && \
    /bin/bash scripts/build.sh

WORKDIR $GOPATH
ENTRYPOINT ["terraform"]
