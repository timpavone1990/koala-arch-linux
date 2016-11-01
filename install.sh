#!/bin/bash

# Load german keyboard layout for the current session
loadkeys de-latin1

# Update the system clock
timedatectl set-ntp true

parted \
    # Non interactive mode
    -s \
    # Optimal alignment
    -a optimal \
    # Disk to partition
    /dev/sda \
    # Create a new GPT partition table
    mklabel gpt \
    # Create a bios boot partition
    mkpart primary 2048s 4095s \
    # Set partition type for the bios boot partition
    set 1 bios_grub on \
    # Set a name for the bios boot partition
    name 1 "'BIOS boot partition'" \
    # Create a primary partition
    mkpart primary ext4 4096s 100% \
    # Set the partition type to lvm for the main partition
    set 2 lvm on \
    # Set a name for the main partition
    name 2 system

# Create physical volume on the main partition
pvcreate /dev/sda2

# Create a volume group of the whole physical volume
vgcreate vg1 /dev/sda2

# Create a new main logical volume
lvcreate \
    # 98% of the whole volume group
    -l 98%VG \
    # Name system
    -n system \
    # Volume group to use
    vg1

# Create a file system on the main logical volume
mkfs.ext4 \
    # Label
    -L system \
    # Device
    /dev/vg1/system

# Create a new swap logical volume
lvcreate \
    # 100% of the space left in the volume group
    -l 100%FREE \
    # Name swap
    -n swap \
    # Volume group to use
    vg1

# Create a swap file system on the swap logical volume
mkswap /dev/vg1/swap

# Mount the main logical volume to /mnt
mount /dev/vg1/system /mnt

# Activate the swap logical volume in order to be detected later by genfstab
swapon /dev/vg1/swap

# Edit /etc/pacman.d/mirrorlist and select download mirrors
# TODO

# Install base packages
# TODO Append other packages to be installed
pacstrap /mnt \
    adobe-source-code-pro-fonts \
    base \
    base-devel \
    grub \
    gtkmm \
    # kde-applications-meta?
    kde-l10n-de \
    lvm2 \
    nfs-utils \
    open-vm-tools \
    openssh \
    # Or: plasma-meta?
    plasma-desktop \
    sddm \
    sudo \
    xf86-input-vmmouse \
    xf86-video-vmware \
    xorg-server \
    zsh \
    zsh-syntax-highlighting

# Install yaourt
curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz
tar -xvzf package-query.tar.gz
cd package-query
makepkg -si
cd ..
curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
tar -xvzf yaourt.tar.gz
cd yaourt
makepkg -si

# Install packages from the AUR
yaourt \
    google-chrome \
    jdk \
    oh-my-zsh-git \
    spotify

# Generate fstab using UUIDs
genfstab -U /mnt >> /mnt/etc/fstab
echo "192.168.0.9:/mnt/FatLady/Shared\040Folders /mnt/Share/ nfs noauto,retry=0,rw,soft,user 0 0" >> /mnt/etc/fstab 
echo "192.168.0.9:/mnt/FatLady/User\040Folders/tim /mnt/Homes/tim/ nfs noauto,retry=0,rw,soft,user 0 0" >> /mnt/etc/fstab

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

# Set root password
passwd

# Create user tim
useradd \
    # Create home directory
    -m
    # Save full name in the comment
    -c "Tim Gremplewski" \
    # Set zsh as default shell
    -s /usr/bin/zsh \
    # Add tim to sudoers group
    -G wheel \
    # Login name
    tim

# Set password for user tim
passwd tim

# Copy zsh settings
cp tim.zshrc /home/tim/.zshrc

# Copy login script
cp tim.zlogin /home/tim/.zlogin

# Copy font rendering settings
cp .fonts.conf /home/tim/

# Copy .gitconfig
cp tim.gitconfig /home/tim/.gitconfig

# Create user gremplewski
useradd \
    # Create home directory
    -m
    # Save full name in the comment
    -c "Tim Gremplewski" \
    # Set zsh as default shell
    -s /usr/bin/zsh \
    # Add gremplewski to sudoers group
    -G wheel \
    # Login name
    gremplewski

# Set password for gremplewski
passwd gremplewski

# Configure boot loader
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

# Enable dhcp client
systemctl enable dhcpcd.service

# Enable sddm
systemctl enable sddm

# Enable VMware tools
systemctl enable vmware-vmblock-fuse.service

# Exit the chroot environment
exit

# Unmount the partitions
umount -R /mnt

reboot
