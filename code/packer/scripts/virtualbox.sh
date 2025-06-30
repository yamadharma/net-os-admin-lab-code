#!/bin/sh

## Mount the VBoxGuestAdditions.iso.

echo "Mounting the VBoxGuestAdditions.iso..."
sudo mount -o loop /home/vagrant/VBoxGuestAdditions.iso /mnt

echo "Running VBoxLinuxAdditions.run..."
sudo /mnt/VBoxLinuxAdditions.run

echo "Unmounting the ISO..."
sudo umount /mnt

echo "Cleaning up..."
sudo rm -f /home/vagrant/VBoxGuestAdditions.iso

# echo "Enable service..."
# sudo systemctl enable --now vboxadd.service
