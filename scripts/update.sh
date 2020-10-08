#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# upgrade system
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get upgrade -yq