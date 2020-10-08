#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# this script is run on the host and uses the host's systemd to manipulate things in the chroot
SYSTEMD_ROOT=/tmp/packer-zeropi

# set locale settings
systemd-firstboot --root="${SYSTEMD_ROOT}" \
    --locale=en_US.UTF-8 \
    --keymap=de-latin1 \
    --timezone=Europe/Berlin \
    --delete-root-password

# replace NetworkManager with systemd-networkd
systemctl --root="${SYSTEMD_ROOT}" disable NetworkManager
systemctl --root="${SYSTEMD_ROOT}" enable systemd-networkd
systemctl --root="${SYSTEMD_ROOT}" enable systemd-resolved
