function enableNtp() {
    timedatectl set-ntp true
}

function setTimeZone() {
    # 'timedatectl set-timezone' does not work in chroot
    ln --force \
       --symbolic \
       /usr/share/zoneinfo/$1 \
       /etc/localtime
}
