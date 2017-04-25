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

if [ -e /var/tmp/resources/bsdrp.img ]
then
  mv /var/tmp/resources/bsdrp.img /var/lib/qcow2/

else
  curl -s -o /var/lib/qcow2/bsdrp.img.xz https://netix.dl.sourceforge.net/project/bsdrp/BSD_Router_Project/current/amd64/BSDRP-${BSDRP_VERSION}-full-amd64-serial.img.xz
  xz -d /var/lib/qcow2/bsdrp.img.xz

fi

mkdir /etc/service/bsdrp

mv /var/tmp/resources/etc/service/consul-template \
   /etc/service

mv /var/tmp/resources/etc/consul-template \
   /etc
mv /var/tmp/resources/etc/consul-agent \
   /etc
