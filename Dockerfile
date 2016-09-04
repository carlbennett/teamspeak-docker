# vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4 colorcolumn=0:

FROM centos:7

MAINTAINER carlbennett <https://github.com/carlbennett>

ENV TSV=3.0.13.3
ENV TSV_SHA256=e9f48c8a9bad75165e3a7c9d9f6b18639fd8aba63adaaa40aebd8114166273ae
ENV TSV_URL=http://dl.4players.de/ts/releases/${TSV}/teamspeak3-server_linux_amd64-${TSV}.tar.bz2

RUN yum update -y && \
    yum install -y bzip2

ADD ${TSV_URL} ts3.tar.bz2
RUN test "${TSV_SHA256}" = "$(sha256sum ts3.tar.bz2 | cut -d\  -f1)"
RUN tar jxf ts3.tar.bz2 && \
    mv teamspeak3-server_linux_amd64 /opt/teamspeak && \
    rm ts3.tar.bz2

ADD ./entrypoint.sh /opt/entrypoint.sh

EXPOSE 9987/udp 30033 10011

RUN    mkdir /opt/tsdata
VOLUME ["/opt/tsdata"]

USER nobody

ENTRYPOINT ["/opt/entrypoint.sh"]
