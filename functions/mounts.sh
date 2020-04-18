function createMountPoints() {
    mkdir --parents \
          /mnt/Daten \
          /mnt/eS_Share \
          /mnt/Homes/gremplewski \
          /mnt/Homes/tim \
          /mnt/Share \
          /mnt/Windows
}

function generateInitialFstab() {
    genfstab -U /mnt >> /mnt/etc/fstab
}

function appendCustomEntriesToFstab() {
    cat $CONFIGURATION_FILES_DIR/fstab \
        >> /etc/fstab
}
