#!/bin/bash

cd "$( cd "$(dirname "$0")" ; pwd -P )"

docker build -t "draeath/vector-build:latest" \
  --build-arg REALUID="$(id -u)" \
  --build-arg REALGID="$(id -g)" \
  --build-arg REALUSR="$(id -n -u)" \
  --build-arg REALGRP="$(id -n -g)" \
  -f build.Dockerfile .
