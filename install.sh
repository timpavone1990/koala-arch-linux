#!/bin/bash

# Load german keyboard layout for the current session
loadkeys de-latin1

# Update the system clock
timedatectl set-ntp true

source partitioning.sh

# Edit /etc/pacman.d/mirrorlist and select download mirrors
# TODO

source packages.sh
source mounts.sh

# Change root into the new system
arch-chroot /mnt

# Set German locale
echo "de_DE.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo LANG=de_DE.UTF-8 > /etc/locale.conf

# Set the hostname
echo "arch01" > /etc/hostname

# TODO patch /etc/hosts with new hostname

# Add lvm2 hook to /etc/mkinitcpio.conf (before filesystem)
# Set SDDM theme to breeze (/etc/sddm.conf) https://wiki.archlinux.org/index.php/SDDM#Theme_settings

# Create a new initial RAM disk
mkinitcpio -p linux

# Configure boot loader
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

source users.sh
source environment.sh
source services.sh

# Exit the chroot environment
exit

# Unmount the partitions
umount -R /mnt

reboot
