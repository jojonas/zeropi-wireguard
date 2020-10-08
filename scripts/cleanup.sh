#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# clean up
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/packer