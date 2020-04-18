function setupMirrorUpdateJob() {
    cat $CONFIGURATION_FILES_DIR/mirrors.service \
        > /etc/systemd/system/mirrors.service

    cat $CONFIGURATION_FILES_DIR/mirrors.timer \
        > /etc/systemd/system/mirrors.timer

    systemctl unmask mirrors.timer
}

function updateMirrorlist() {
    curl "https://www.archlinux.org/mirrorlist/?country=DE&protocol=https&ip_version=4&use_mirror_status=on" \
         > /etc/pacman.d/mirrorlist

    sed --in-place \
        '/^#/ s/^#//' \
        /etc/pacman.d/mirrorlist

    pacman --sync \
           --refresh \
           --refresh
}