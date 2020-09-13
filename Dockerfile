ARG ARCHITECTURE

FROM multiarch/ubuntu-core:${ARCHITECTURE}-focal

ENV SYSTEMCL_VERSION=v1.5.4260

# Install steps from here: https://github.com/gdraheim/docker-systemctl-replacement/tree/v1.5.4260#service-manager
# iproute2 is needed for IP information in setup module:
# https://stackoverflow.com/questions/41469740/ansible-default-ipv4-address-undefined-in-docker-ubuntu
RUN apt-get update && \
    apt-get install -y \
      python3 \
      sudo \
      bash \
      ca-certificates \
      iproute2

RUN test -d /run/systemd/system || mkdir -p /run/systemd/system
ADD https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/${SYSTEMCL_VERSION}/files/docker/systemctl3.py /usr/bin/systemctl

# Add non root user with sudo privileges
# password is password encrypted with `mkpasswd password`
RUN chmod +x /usr/bin/systemctl && \
    useradd --groups sudo --create-home --password BLkvn6sbzJ1BE user

# Setup passwordless sudo
RUN echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/1-user
