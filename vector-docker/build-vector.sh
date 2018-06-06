#!/bin/bash

CHECKOUT=${1:-"tags/v1.2.2"}

cd "$( cd "$(dirname "$0")" ; pwd -P )" || exit

docker build -t "draeath/vector-host:latest" --build-arg CHECKOUT="${CHECKOUT}" .
