#!/bin/bash

VECTORPORT=${1:-8080}

cd "$( cd "$(dirname "$0")" ; pwd -P )" || exit

if ! docker image inspect "draeath/vector-host:latest" > /dev/null 2>&1; then
  ./build-vector.sh || exit
fi

docker run -it --name="vector" --rm -p ${VECTORPORT}:8080 draeath/vector-host:latest
