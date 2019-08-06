This is a silly docker/podman container to run Netflix' Vector.

The scripts check that everything they need exists, so you don't have to run them one-by-one, just run `run-vector.sh` and it will run the builds if necessary.

It defaults to port 8080, if you want something different all you have to do is pass it as an argument. The script doesn't handle any other kind of argument, just the port number (or nothing at all, to default to 8080).

The script assigns the name "vector" to the docker container to prevent you from running more than one at the same time.

- [run-vector.sh](vector-docker/run-vector.sh)
  This runs the container.
- [build-vector.sh](vector-docker/build-vector.sh)
  This builds vector itself.
- [Dockerfile](vector-docker/Dockerfile)
  This is the Dockerfile for the whole thing. It uses a mutli-stage build, as is the fad these days.

If you want a different version of vector, either edit the default in [build-vector.sh](vector-docker/build-vector.sh) or run that script manually with the git checkout term (eg "tags/v1.3.2") you want.
