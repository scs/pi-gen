#!/bin/bash -e

install -m 644 files/influxdb.list "${ROOTFS_DIR}/etc/apt/sources.list.d/"
install -m 644 files/grafana.list "${ROOTFS_DIR}/etc/apt/sources.list.d/"

sed -i "s/RELEASE/${RELEASE}/g" "${ROOTFS_DIR}/etc/apt/sources.list.d/influxdb.list"

on_chroot << EOF
wget -qO- https://repos.influxdata.com/influxdb.key | apt-key add -
wget -qO- https://packages.grafana.com/gpg.key | apt-key add -
EOF

on_chroot << EOF
apt-get update
EOF

# Download Smart Meter Data Collector
wget \
    -O "${ROOTFS_DIR}/tmp/python3-smartmeter-datacollector.deb" \
    "https://github.com/scs/smartmeter-datacollector/releases/download/v1.0.0/python3-smartmeter-datacollector_1.0.0-1_armhf.deb"

# Download Smart Meter Data Collector Configurator
wget \
    -O "${ROOTFS_DIR}/tmp/python3-smartmeter-datacollector-configurator.deb" \
    "https://github.com/scs/smartmeter-datacollector-configurator/releases/download/v1.0.0/python3-smartmeter-datacollector-configurator_1.0.0-1_armhf.deb"
