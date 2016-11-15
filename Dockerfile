FROM centos:7
MAINTAINER Ben Wu <wucheokman@gmail.com>

RUN yum -y update \
    && yum -y install tar \
    git \
    wget \
    && yum clean all

ENV GRAPHITE_ROOT /graphite

ADD carbon.conf /graphite/conf/carbon.conf

RUN mkdir -p $GRAPHITE_ROOT/conf && \
    mkdir -p $GRAPHITE_ROOT/storage && \
    touch $GRAPHITE_ROOT/conf/storage-aggregation.conf && \
    touch $GRAPHITE_ROOT/conf/storage-schemas.conf 

VOLUME /whisper
EXPOSE 2003 2004 7002

ENTRYPOINT ["/usr/bin/twistd", "--nodaemon", \
            "--reactor=epoll", "--no_save"]
CMD ["carbon-cache"]