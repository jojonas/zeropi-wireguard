#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

test -n "${PACKER_USER}" || (echo "environment variable PACKER_USER not set." >&2; exit 1)
test -n "${PACKER_SSH_KEY}" || (echo "environment variable PACKER_SSH_KEY not set." >&2; exit 1)

# install defaults for new users
install -m750 /tmp/packer/zshrc /etc/skel/.zshrc

# create new user
PACKER_USER_HOME=/home/${PACKER_USER}
groupadd --system "sshusers"
useradd --create-home --user-group --home-dir "${PACKER_USER_HOME}" --shell /bin/zsh "${PACKER_USER}"
usermod -a -G "sudo,sshusers" "${PACKER_USER}"

# set up sudoers
echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/sudo-group-nopasswd
chmod 600 /etc/sudoers.d/sudo-group-nopasswd

# install SSH key
mkdir -p ${PACKER_USER_HOME}/.ssh
echo "${PACKER_SSH_KEY}" >> ${PACKER_USER_HOME}/.ssh/authorized_keys
chown -R "${PACKER_USER}": ${PACKER_USER_HOME}/.ssh
chmod 700 ${PACKER_USER_HOME}/.ssh

# remove insecure root password
# note that the serial console via UART automatically logs in as root
passwd --delete root

# disable root's password change on first login
rm -f /root/.not_logged_in_yet
rm -f /root/.desktop_autologin