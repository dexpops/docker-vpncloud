FROM debian:9

ENV VPNCLOUD_VERSION "0.8.2"

RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
    wget \
    tar \
    host \
    net-tools \
    git \
    build-essential \
    cargo \
    ca-certificates && \
    apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

COPY files/vpncloud_${VPNCLOUD_VERSION}_amd64.deb /opt/vpncloud_${VPNCLOUD_VERSION}_amd64.deb
COPY files/vpncloud.yml /etc/vpncloud.yml
COPY entrypoint.sh /entrypoint.sh

RUN dpkg -i vpncloud_${VPNCLOUD_VERSION}_amd64.deb

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]