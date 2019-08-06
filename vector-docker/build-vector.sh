#!/bin/bash

CHECKOUT=${1:-"tags/v1.3.2"}

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

runtime build -t "draeath/vector-host:latest" --build-arg CHECKOUT="${CHECKOUT}" .
