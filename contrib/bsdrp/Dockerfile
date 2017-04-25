FROM vpipes-base-image:16.04
MAINTAINER Foucault de Bonneval <foucault(at)commit.ninja>
ENV DEBIAN_FRONTEND noninteractive

ARG BSDRP_VERSION
ARG BRIDGES

ADD resources /var/tmp/resources
RUN /var/tmp/resources/build.sh
ENV SVDIR="/etc/service"
ENV VTYPE="bsdrp"
ENV VINTF="${BRIDGES}"

EXPOSE 23

CMD ["/sbin/runit"]
