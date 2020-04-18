#!/bin/bash

BASE_DIR=$(dirname "${BASH_SOURCE[0]}")
CONFIGURATION_FILES_DIR=configuration_files

cd $BASE_DIR

source $BASE_DIR/functions/boot.sh
source $BASE_DIR/functions/locale.sh
source $BASE_DIR/functions/login.sh
source $BASE_DIR/functions/mirrors.sh
source $BASE_DIR/functions/mounts.sh
source $BASE_DIR/functions/network.sh
source $BASE_DIR/functions/packages.sh
source $BASE_DIR/functions/services.sh
source $BASE_DIR/functions/timedate.sh
source $BASE_DIR/functions/ulimit.sh
source $BASE_DIR/functions/users.sh

setTimeZone "Europe/Berlin"
setKeymap "de-latin1"
generateGermanLocale

createMountPoints
appendCustomEntriesToFstab

setSddmConfiguration "Current" "breeze"
setSddmConfiguration "CursorTheme" "breeze_cursors"
cp $CONFIGURATION_FILES_DIR/environment /etc

setHostname
setHosts
setKerberosConfig
enableSudoForGroupWheel
setRootPassword
createUser "Tim Gremplewski" "tim"
createUser "Tim Gremplewski" "gremplewski"

# Allow user nobody to run pacman with sudo without asking for a password
echo "nobody ALL= NOPASSWD:/usr/bin/pacman" >> /etc/sudoers
installAurman
installAurPackages
installAdditionalPackages
# Remove additional permission for user nobody
sed --in-place \
    '$ d' \
    /etc/sudoers

setupMirrorUpdateJob
clearPacmanCache

setUlimits

addLvm2Hook
createInitialRamDisk
setGrubConfiguration "GRUB_GFXMODE" "1280x1024"
setGrubConfiguration "GRUB_TIMEOUT" "0"
installBootloader

# timedatectl is not available in chroot, therefore enable ntp by enablling systemd-timesyncd manually
enableServices \
    dhcpcd.service \
    mirrors.timer \
    org.cups.cupsd.service \
    sddm \
    systemd-timesyncd \
    vmtoolsd.service \
    vmware-vmblock-fuse.service
