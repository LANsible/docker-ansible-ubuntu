FROM ubuntu:focal

ENV SYSTEMCL_VERSION=v1.5.4260

# Install steps from here: https://github.com/gdraheim/docker-systemctl-replacement/tree/v1.5.4260#service-manager
RUN apt-get update && \
    apt-get install python3 && \
    mkdir -p /run/systemd/system/

ADD https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/${SYSTEMCL_VERSION}/files/docker/systemctl3.py /usr/bin/systemctl
