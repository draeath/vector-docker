FROM debian:buster as build
ARG CHECKOUT
COPY apt-sources.list /etc/apt/sources.list
COPY nodesource.gpg /etc/apt/trusted.gpg.d/nodesource.gpg
COPY nodesource-prefs /etc/apt/preferences.d/nodesource
ADD https://deb.nodesource.com/node_8.x/pool/main/n/nodejs/nodejs_8.11.3-1nodesource1_amd64.deb /root
RUN echo "set debconf/frontend noninteractive" | DEBIAN_FRONTEND=noninteractive debconf-communicate &&\
    apt-get update &&\
    apt-get dist-upgrade -y &&\
    apt-get install -y build-essential git tar gzip python-minimal &&\
    dpkg -i /root/nodejs_8.11.3-1nodesource1_amd64.deb
RUN useradd -m -s /bin/sh build
USER build
ENV HOME=/home/build
RUN git clone --no-checkout https://github.com/Netflix/vector.git /home/build/vector
WORKDIR /home/build/vector
RUN git reset --hard $CHECKOUT
RUN npm install
RUN npm run build

FROM httpd:alpine as runtime
EXPOSE 80/tcp
COPY --chown=root:root --from=build /home/build/vector/dist /usr/local/apache2/htdocs
