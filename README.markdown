# Brew+OpenDaylight Dockerfile

Logic for building a Docker image with Brew installed and configured for
OpenDaylight RPM packaging.

## Building

Docker [refuses to add][1] additional build permissions to `docker build`,
and `mock` requires the `unshare` system call, so we have to use a hack
to build the image using a combination of a Dockerfile and `docker run`/
`docker commit` commands for privileged actions.

Build the ODL Brew Docker image with:

    ./build_image.sh

## Using

Once you've built the ODL Brew Docker image, you can use `docker run` with the `--cap-add=SYS_ADMIN` capability to access the Brew CLI tool and ODL's mock environment.

Get a shell on the ODL Brew Docker image:

    docker run --cap-add=SYS_ADMIN -it brew bash

List OpenDaylight's packages:

    docker run --cap-add=SYS_ADMIN -it brew"brew list-pkgs | grep opendaylight

Drop into the mock shell:

    docker run --cap-add=SYS_ADMIN -it brew su - -c "mock -r rhos-10.0-odl-rhel-7-build --shell" mock

[1]: https://github.com/docker/docker/issues/1916 "Docker will not add privileged builds"
