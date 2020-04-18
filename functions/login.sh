function setSddmConfiguration() {
    sed --in-place \
        "/^$1/ s/=.*$/=$2/" \
        /etc/sddm.conf
}
