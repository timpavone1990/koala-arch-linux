#!/bin/bash

BASE_DIR=$(dirname "${BASH_SOURCE[0]}")
CONFIGURATION_FILES_DIR=configuration_files

cd $BASE_DIR

source $BASE_DIR/functions/chroot.sh
source $BASE_DIR/functions/locale.sh
source $BASE_DIR/functions/mirrors.sh
source $BASE_DIR/functions/mounts.sh
source $BASE_DIR/functions/packages.sh
source $BASE_DIR/functions/partitioning.sh
source $BASE_DIR/functions/timedate.sh

setTimeZone "Europe/Berlin"
enableNtp

partitionDisk
updateMirrorlist
strapBaseSystem
generateInitialFstab

prepareChrootSetup
startChrootSetup
cleanUpChrootSetup

umount -R /mnt
reboot
