function setHostname() {
    cat $CONFIGURATION_FILES_DIR/hostname \
        > /etc/hostname
}

function setHosts() {
    cat $CONFIGURATION_FILES_DIR/hosts \
        >> /etc/hosts
}

function setKerberosConfig() {
    cat $CONFIGURATION_FILES_DIR/krb5.conf \
        > /etc/krb5.conf
}
