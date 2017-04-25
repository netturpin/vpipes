FROM ubuntu:16.04
MAINTAINER Foucault de Bonneval <foucault(at)commit.ninja>
ENV DEBIAN_FRONTEND noninteractive

ARG CONSUL_VERSION
ARG CONSUL_TEMPLATE_VERSION

ADD resources /var/tmp/resources
RUN /var/tmp/resources/build.sh
ENV SVDIR="/etc/service"

CMD ["/sbin/runit"]
