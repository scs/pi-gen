#!/bin/bash -e

on_chroot << EOF
wget -qO- https://repos.influxdata.com/influxdata-archive_compat.key | \
    gpg --dearmor -o /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg
wget -qO- https://apt.grafana.com/gpg.key | \
    gpg --dearmor -o /etc/apt/trusted.gpg.d/grafana.gpg
EOF

install -m 644 files/influxdb.list "${ROOTFS_DIR}/etc/apt/sources.list.d/"
install -m 644 files/grafana.list "${ROOTFS_DIR}/etc/apt/sources.list.d/"

on_chroot << EOF
apt-get update
EOF

# Download Smart Meter Data Collector
wget \
    -O "${ROOTFS_DIR}/tmp/python3-smartmeter-datacollector.deb" \
    "https://github.com/scs/smartmeter-datacollector/releases/download/v1.2.0/python3-smartmeter-datacollector_1.2.0-1_armhf.deb"

# Download Smart Meter Data Collector Configurator
wget \
    -O "${ROOTFS_DIR}/tmp/python3-smartmeter-datacollector-configurator.deb" \
    "https://github.com/scs/smartmeter-datacollector-configurator/releases/download/v1.2.0/python3-smartmeter-datacollector-configurator_1.2.0-1_armhf.deb"
