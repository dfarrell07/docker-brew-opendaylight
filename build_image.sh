#!/usr/bin/env bash
set -e
set -x

# Build the ODL Brew docker image
# This is required because mock requires the ushare system call, but Docker
# refuses to add support for privileged builds. The standard work-around is
# to build as much as you can in a Dockerfile, then use `docker run`s with
# the required privileges, then commit the result.

docker build -t brew .

# TODO: Extract these to a build and commit function

docker run --cap-add=SYS_ADMIN --cidfile=brew.cid brew su - mock -c "mock -r rhos-10.0-odl-rhel-7-build --init"
docker commit `cat brew.cid` brew
rm brew.cid

docker run --cap-add=SYS_ADMIN --cidfile=brew.cid brew su - -c 'mock -r rhos-10.0-odl-rhel-7-build --shell "echo \"127.1.0.1   nexus.opendaylight.org\" >> /etc/hosts"' mock
docker commit `cat brew.cid` brew
rm brew.cid

docker run --cap-add=SYS_ADMIN --cidfile=brew.cid brew su - -c 'mock -r rhos-10.0-odl-rhel-7-build --shell "echo \"127.1.0.2   repo.maven.apache.org\" >> /etc/hosts"' mock
docker commit `cat brew.cid` brew
rm brew.cid

docker run --cap-add=SYS_ADMIN --cidfile=brew.cid brew su - -c 'mock -r rhos-10.0-odl-rhel-7-build --shell "echo \"127.1.0.3   oss.sonatype.org\" >> /etc/hosts"' mock
docker commit `cat brew.cid` brew
rm brew.cid

docker run --cap-add=SYS_ADMIN --cidfile=brew.cid brew su - -c 'mock -r rhos-10.0-odl-rhel-7-build --shell "echo \"127.1.0.4   registry.npmjs.org\" >> /etc/hosts"' mock
docker commit `cat brew.cid` brew
rm brew.cid
