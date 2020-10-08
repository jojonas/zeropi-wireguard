#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# install SSH configuration
install -m644 /tmp/packer/sshd_config /etc/ssh/sshd_config.d/config
