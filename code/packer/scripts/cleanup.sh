#!/bin/sh

sudo dnf -y clean all

# Remove Virtualbox specific files
sudo rm -rf /usr/src/vboxguest* /usr/src/virtualbox-ose-guest*
sudo rm -rf *.iso *.iso.? /tmp/vbox /home/vagrant/.vbox_version

# Cleanup log files
sudo find /var/log -type f | while read f; do echo -ne '' >$f; done

# remove under tmp directory
sudo rm -rf /tmp/*

# zero out empty space
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -rf /EMPTY
