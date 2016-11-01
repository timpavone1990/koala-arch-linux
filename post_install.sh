#!/bin/bash

# Set keyboard layout
localectl set-keymap de-latin1

# Set the timezone
timedatectl set-timezone Europe/Berlin

# Start and enable service to update the system clock
timedatectl set-ntp true

# Update the system
pacman -Syu

# Set fonts in KDE settings
