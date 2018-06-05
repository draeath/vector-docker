FROM debian:stretch

ARG REALUID="1000"
ARG REALGID="1000"
ARG REALUSR="builder"
ARG REALGRP="builder"

RUN echo "set debconf/frontend noninteractive" | DEBIAN_FRONTEND=noninteractive debconf-communicate &&\
    apt-get update &&\
    apt-get dist-upgrade -y &&\
    apt-get install -y apt-transport-https &&\
    rm -rf /var/lib/apt/lists/*

COPY apt-sources.list /etc/apt/sources.list
COPY nodesource.gpg /etc/apt/trusted.gpg.d/nodesource.gpg

RUN apt-get update &&\
    apt-get install -y build-essential git nodejs tar gzip &&\
    rm -rf /var/lib/apt/lists/* &&\
    echo "set debconf/frontend dialog" | DEBIAN_FRONTEND=noninteractive debconf-communicate

RUN npm install -g bower gulp-cli

RUN mkdir -pv /mnt/external

RUN groupadd -g "$REALGID" "$REALGRP"
RUN useradd -u "$REALUID" -g "$REALGRP" -m -N -s /bin/sh "$REALUSR"
USER "$REALUSR"
ENV HOME=/home/"$REALUSR"

RUN git clone https://github.com/Netflix/vector.git ${HOME}/vector

WORKDIR ${HOME}/vector
CMD touch /mnt/external/write-test &&\
    rm -f /mnt/external/write-test &&\
    git pull &&\
    git checkout tags/v1.2.2 &&\
    npm install &&\
    bower install &&\
    gulp build &&\
    rm -f /mnt/external/vector.tgz &&\
    tar cvzf /mnt/external/vector.tgz -C dist .
