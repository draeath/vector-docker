#!/bin/bash

VECTORPORT=${1:-8080}

runtime() {
  if hash docker 2>/dev/null; then
    docker "$@"
  elif hash podman 2>/dev/null; then
    podman "$@"
  else
    echo "You need docker or podman!" >&2
    exit 1
  fi
}

cd "$( cd "$(dirname "$0")" ; pwd -P )" || exit

if ! runtime image inspect "draeath/vector-host:latest" > /dev/null 2>&1; then
  ./build-vector.sh || exit
fi

runtime run -d --name="vector" --rm -p ${VECTORPORT}:80 draeath/vector-host:latest
