FROM ubuntu:latest
LABEL maintainer="Erez Buchnik <erez@shrewdthings.com>"

ENV SRC_DIR=/usr/src

COPY entrypoint/*.sh ${SRC_DIR}/
ENV BASH_ENV=${SRC_DIR}/docker-entrypoint.sh
SHELL ["/bin/bash", "-c"]

# Install InfluxDB:
###################
RUN echo "\
deb https://repos.influxdata.com/ubuntu bionic stable" >> \
/etc/apt/sources.list.d/influxdb.list
RUN curl -sL https://repos.influxdata.com/influxdb.key | apt-key add -
RUN apt-get update
RUN apt-get install influxdb
RUN systemctl enable influxdb
###################

# Check:
########
RUN systemctl is-enabled influxdb
########
