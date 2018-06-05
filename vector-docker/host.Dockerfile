FROM debian:stretch

EXPOSE 8080/tcp

RUN echo "set debconf/frontend noninteractive" | DEBIAN_FRONTEND=noninteractive debconf-communicate &&\
    apt-get update &&\
    apt-get dist-upgrade -y &&\
    apt-get install -y apt-transport-https &&\
    rm -rf /var/lib/apt/lists/*

COPY apt-sources.list /etc/apt/sources.list
COPY nodesource.gpg /etc/apt/trusted.gpg.d/nodesource.gpg

RUN apt-get update &&\
    apt-get install -y python3-twisted &&\
    rm -rf /var/lib/apt/lists/* &&\
    echo "set debconf/frontend dialog" | DEBIAN_FRONTEND=noninteractive debconf-communicate

RUN mkdir -pv /twisted-runtime && chown -v nobody:nogroup /twisted-runtime
ADD --chown=nobody:nogroup dist/vector.tgz /root/vector/

USER nobody
WORKDIR /tmp

CMD twistd3 -n -l - web --path /twisted-runtime --port tcp:8080
