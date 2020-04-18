function addLvm2Hook() {
    sed --in-place \
        '/^HOOKS/ s/filesystem/lvm2 filesystem/' \
        /etc/mkinitcpio.conf
}

function createInitialRamDisk() {
    mkinitcpio --preset linux
}

function setGrubConfiguration() {
    sed --in-place \
        "/^$1/ s/=.*$/=$2/" \
        /etc/default/grub    
}

function installBootloader() {
    grub-install --target i386-pc \
                 /dev/sda

    grub-mkconfig --output /boot/grub/grub.cfg
}
