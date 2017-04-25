#!/bin/bash
set -xe

mkdir -p /etc/qemu
for i in ${BRIDGES}
do
  echo "allow ${i}" >> /etc/qemu/bridge.conf
done

mkdir -p /var/lib/qcow2


#################################################
# Customization starts here

if [ -e /var/tmp/resources/cirros.img ]
then
  mv /var/tmp/resources/cirros.img /var/lib/qcow2/

else
  curl -s -o /var/lib/qcow2/cirros.img http://download.cirros-cloud.net/${CIRROS_VERSION}/cirros-${CIRROS_VERSION}-x86_64-disk.img

fi

mkdir /etc/service/cirros

mv /var/tmp/resources/etc/service/consul-template \
   /etc/service

mv /var/tmp/resources/etc/consul-template \
   /etc
mv /var/tmp/resources/etc/consul-agent \
   /etc
