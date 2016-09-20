# Brew+OpenDaylight Dockerfile

Logic for building a Docker image with Brew installed and configured for
OpenDaylight RPM packaging.

Docker [refuses to add][1] additional build permissions to `docker build`,
and `mock` requires the `unshare` system call, so we have to use a hack
to build the image using a combination of a Dockerfile and `docker run`/
`docker commit` commands for privileged actions.

Build the ODL Brew Docker image with:

    ./build_image.sh

Drop into the mock shell:

    docker run --cap-add=SYS_ADMIN -it brew su - -c "mock -r rhos-10.0-odl-rhel-7-build --shell" mock

[1]: https://github.com/docker/docker/issues/1916 "Docker will not add privileged builds"
