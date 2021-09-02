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

# Setup Smart Meter Data Collector
# TODO: mc download data collector Debian package
install -m 644 files/python3-smartmeter-datacollector_0.4.1-1_all_mod.deb "${ROOTFS_DIR}/tmp/python3-smartmeter-datacollector.deb"
