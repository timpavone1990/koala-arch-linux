function generateGermanLocale() {
    sed --in-place \
        '/^#de_DE/ s/^#//' \
        /etc/locale.gen

    locale-gen
    echo LANG=de_DE.UTF-8 > /etc/locale.conf
    
    unset LANG
    source /etc/profile.d/locale.sh
}

function setKeymap() {
    # 'localectl set-keymap' does not work in chroot
    cat $CONFIGURATION_FILES_DIR/vconsole.conf \
        > /etc/vconsole.conf

    cat $CONFIGURATION_FILES_DIR/00-keyboard.conf \
        > /etc/X11/xorg.conf.d/00-keyboard.conf
}
