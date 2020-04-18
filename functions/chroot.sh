function prepareChrootSetup() {
    mkdir --parents \
          /mnt/opt/koala_arch

    cp --recursive \
       . \
       /mnt/opt/koala_arch

    chmod u+x \
          /mnt/opt/koala_arch/chroot_setup.sh

    ln --symbolic \
       --force \
       /usr/bin/pinentry-curses \
       /usr/bin/pinentry

    gpg2 --decrypt \
         /mnt/opt/koala_arch/configuration_files.tar.gz.gpg \
         | tar --extract \
               --ungzip \
               --directory /mnt/opt/koala_arch
}

function startChrootSetup() {
    arch-chroot /mnt \
                /opt/koala_arch/chroot_setup.sh
}

function cleanUpChrootSetup() {
    rm --recursive \
       --force \
       /mnt/opt/koala_arch
}
