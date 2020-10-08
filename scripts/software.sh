#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# install important software
export DEBIAN_FRONTEND=noninteractive
apt-get install -yq vim git tmux zsh nftables