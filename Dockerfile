ARG ARCHITECTURE

FROM multiarch/ubuntu-core:${ARCHITECTURE}-focal

ENV SYSTEMCL_VERSION=v1.5.4260

# Install steps from here: https://github.com/gdraheim/docker-systemctl-replacement/tree/v1.5.4260#service-manager
RUN apt-get update && \
    apt-get install -y \
      python3 \
      sudo \
      bash \
      ca-certificates

RUN test -d /run/systemd/system || mkdir -p /run/systemd/system
ADD https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/${SYSTEMCL_VERSION}/files/docker/systemctl3.py /usr/bin/systemctl

# Add non root user with sudo privileges
# password is password encrypted with `mkpasswd password`
RUN useradd --groups sudo --create-home --password BLkvn6sbzJ1BE user
