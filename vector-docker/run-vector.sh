#!/bin/bash

cd "$( cd "$(dirname "$0")" ; pwd -P )"

if ! docker image inspect "draeath/vector-host:latest" > /dev/null 2>&1; then
  ./build-host.sh || exit
fi

VECTORPORT=${1:-8080}
docker run -it --name="vector" --rm -p ${VECTORPORT}:8080 draeath/vector-host:latest
