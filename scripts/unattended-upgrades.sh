#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# install unattended upgrades config
install -m644 /tmp/packer/50unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades
mkdir -p /etc/systemd/system/apt-daily.timer.d/
install -m644 /tmp/packer/apt-daily.override.timer /etc/systemd/system/apt-daily.timer.d/override.conf
mkdir -p /etc/systemd/system/apt-daily-upgrade.timer.d/
install -m644 /tmp/packer/apt-daily-upgrade.override.timer /etc/systemd/system/apt-daily-upgrade.timer.d/override.conf
