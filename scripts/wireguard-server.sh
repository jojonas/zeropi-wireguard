#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# install wireguard
apt-get install -yq wireguard

pushd /etc/wireguard >/dev/null

# generate key pair
echo "WG public key:"
wg genkey | tee privatekey | wg pubkey | tee publickey

# generate and install preshared keys
# echo "WG PSK:"
# wg genpsk | tee pper.psk

# fix permissions
chown root:systemd-network privatekey publickey *.psk
chmod 640 privatekey
chmod 644 publickey
chmod 640 *.psk

install -m640 -oroot -gsystemd-network /tmp/packer/99-wg0.netdev /etc/systemd/network/99-wg0.netdev
install -m640 -oroot -gsystemd-network /tmp/packer/99-wg0.network /etc/systemd/network/99-wg0.network

popd >/dev/null

