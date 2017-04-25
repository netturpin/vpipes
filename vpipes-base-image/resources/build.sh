#!/bin/bash
set -xe

# Install dependencies
apt-get update
apt-get upgrade -y
apt-get install -y \
  bridge-utils \
  curl \
  dnsutils \
  iproute2 \
  jq \
  iputils-ping \
  kmod \
  qemu-kvm \
  runit \
  ssh-client \
  tshark \
  unzip \
  vim \
  xz-utils

# Install Consul
curl --fail -s -o consul.zip https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip
unzip consul.zip -d /usr/sbin
rm consul.zip
mkdir /var/lib/consul
# Install Consul Template
curl --fail -s -o consul-template.zip https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip
unzip consul-template.zip -d /usr/sbin
rm consul-template.zip

mkdir -p /etc/qemu
mkdir -p /var/lib/qcow2
#mkdir -p /etc/consul-agent

# Moving runit and consul configuration to /etc
mv /var/tmp/resources/etc/service/consul-agent \
   /etc/service
mv /var/tmp/resources/etc/runit \
   /etc

