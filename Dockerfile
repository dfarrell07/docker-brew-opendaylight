# Dockerfile for Brew, Red Hat's highly customized Koji instance
# This will only work inside the Red Hat network, sorry.
FROM centos:7
MAINTAINER Daniel Farrell <dfarrell@redhat.com>

# Install Brew from internal repo
RUN curl -L --silent -o /etc/yum.repos.d/rcm-tools-rhel-7-server.repo "http://download.devel.redhat.com/rel-eng/RCMTOOLS/rcm-tools-rhel-7-server.repo"
RUN yum install -y brewkoji

# Install packaging dev tools like mock
RUN yum install -y centos-packager

# Create unprivliged mock user
RUN useradd -g mock mock

# Copy mock config to container
ADD rhos-10.0-odl-rhel-7-build.cfg /etc/mock/
