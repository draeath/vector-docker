This is a silly docker container to run Netflix' Vector.

The scripts check that everything they need exists, so you don't have to run
them one-by-one, just run `run-vector.sh` and it will run the builds if
necessary.

It defaults to port 8080, if you want something different all you
have to do is pass it as an argument. The script doesn't handle any other kind
of argument, just the port number (or nothing at all, to default to 8080).

The script assigns the name "vector" to the docker container to prevent you
from running more than one at the same time.

- [run-vector.sh](vector-docker/run-vector.sh)
  This runs vector via python3-twisted.
- [build-host.sh](vector-docker/build-host.sh)
  This builds the hosting environment. It's only got what it needs for that.
- [build-vector.sh](vector-docker/build-vector.sh)
  This executes the build environment container, and produces vector itself.
- [build-buildenvironment.sh](vector-docker/build-buildenvironment.sh)
  This builds the build environment. It's got a bunch of compiling stuff.
- [host.Dockerfile](vector-docker/host.Dockerfile)
  This is the Dockerfile for the hosting environment.
- [build.Dockerfile](vector-docker/build.Dockerfile)
  This is the Dockerfile for the build environment. Notably, the version of
  vector to build is defined in here. Look for the `git checkout` near the end.
