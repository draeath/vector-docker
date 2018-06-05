#!/bin/bash

cd "$( cd "$(dirname "$0")" ; pwd -P )"

if [ ! -f dist/vector.tgz ]; then
  ./build-vector.sh || exit
fi

docker build -t "draeath/vector-host:latest" \
  -f host.Dockerfile .
