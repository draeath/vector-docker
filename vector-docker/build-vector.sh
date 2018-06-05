#!/bin/bash

cd "$( cd "$(dirname "$0")" ; pwd -P )"

if ! docker image inspect "draeath/vector-build:latest" > /dev/null 2>&1; then
  ./build-buildenvironment.sh || exit
fi

docker run --rm -v "$(readlink -f ./dist):/mnt/external:rw" "draeath/vector-build:latest" 
