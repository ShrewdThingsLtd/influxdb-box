FROM ubuntu:latest
LABEL maintainer="Erez Buchnik <erez@shrewdthings.com>"

ENV SRC_DIR=/usr/src

COPY entrypoint/*.sh ${SRC_DIR}/
ENV BASH_ENV=${SRC_DIR}/docker-entrypoint.sh
SHELL ["/bin/bash", "-c"]

# Install InfluxDB:
###################
RUN curl -sL https://repos.influxdata.com/influxdb.key | apt-key add -
RUN source /etc/lsb-release; \
  echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
RUN apt-get update
RUN apt-get -y install influxdb
RUN systemctl enable influxdb
###################

# Check:
########
RUN systemctl is-enabled influxdb
########

ENTRYPOINT ["${SRC_DIR}/app-entrypoint.sh"]
CMD ["/bin/bash"]
