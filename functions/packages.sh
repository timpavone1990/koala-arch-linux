function clearPacmanCache() {
    pacman --sync \
           --clean \
           --clean \
           --noconfirm
}

function installAdditionalPackages() {
    pacman --sync \
           --needed \
           --noconfirm \
           adobe-source-code-pro-fonts \
           git \
           gradle \
           keepassx2 \
           maven \
           source-highlight \
           vlc
}

function installAurPackages() {
    sudo -u nobody \
         aurman --sync \
                --needed \
                --noconfirm \
                --aur \
                google-chrome \
                jdk \
                oh-my-zsh-git \
                samsung-unified-driver \
                spotify \
                visual-studio-code-bin
}

function installAurman() {
    cd /tmp

    curl --remote-name https://aur.archlinux.org/cgit/aur.git/snapshot/aurman.tar.gz

    tar --extract \
        --ungzip \
        --file aurman.tar.gz

    chown --recursive \
          nobody:nobody \
          aurman

    cd aurman

    sudo -u nobody \
         makepkg --syncdeps \
                 --install \
                 --needed \
                 --noconfirm
}

function strapBaseSystem() {
    pacstrap /mnt \
             --needed \
             base \
             base-devel \
             breeze-gtk \
             breeze-kde4 \
             grub \
             gtkmm \
             kde-applications-meta \
             kde-l10n-de \
             lvm2 \
             nfs-utils \
             open-vm-tools \
             openssh \
             pam-krb5 \
             plasma-meta \
             reflector \
             sddm \
             sudo \
             xf86-input-vmmouse \
             xf86-video-vmware \
             xorg-server \
             xorg-server-utils \
             zsh \
             zsh-syntax-highlighting
}
