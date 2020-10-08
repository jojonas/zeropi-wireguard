#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# install systemd-networkd configuration
install -m644 /tmp/packer/50-dhcp.network /etc/systemd/network/50-dhcp.network
install -m644 /tmp/packer/resolved.conf /etc/systemd/resolved.conf
mkdir -p /etc/systemd/dnssd
install -m644 /tmp/packer/ssh.dnssd /etc/systemd/dnssd/ssh.dnssd

# install systemd-resolve symlink
rm -rf /etc/resolv.conf
ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf

# the actual service replacement is done by host's systemd in local-systemd.sh