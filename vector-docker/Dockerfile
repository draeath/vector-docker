FROM debian:stretch as base
RUN echo "set debconf/frontend noninteractive" | DEBIAN_FRONTEND=noninteractive debconf-communicate &&\
    apt-get update &&\
    apt-get dist-upgrade -y &&\
    apt-get install -y apt-transport-https python-twisted &&\
    rm -rf /var/lib/apt/lists/*

FROM base as build
ARG CHECKOUT
COPY apt-sources.list /etc/apt/sources.list
COPY nodesource.gpg /etc/apt/trusted.gpg.d/nodesource.gpg
RUN apt-get update &&\
    apt-get install -y build-essential git nodejs tar gzip &&\
    rm -rf /var/lib/apt/lists/*
RUN npm install -g bower gulp-cli
RUN useradd -m -s /bin/sh build
USER build
ENV HOME=/home/build
RUN git clone --no-checkout https://github.com/Netflix/vector.git /home/build/vector
WORKDIR /home/build/vector
RUN git checkout $CHECKOUT &&\
    npm install &&\
    bower install &&\
    gulp build

FROM httpd:alpine as runtime
EXPOSE 80/tcp
COPY --chown=root:root --from=build /home/build/vector/dist /usr/local/apache2/htdocs
