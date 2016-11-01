# Install packages
pacstrap /mnt \
    adobe-source-code-pro-fonts \
    atom \
    base \
    base-devel \
    gradle \
    grub \
    gtkmm \
    # kde-applications-meta?
    kde-l10n-de \
    lvm2 \
    maven \
    nfs-utils \
    open-vm-tools \
    openssh \
    # Or: plasma-meta?
    plasma-desktop \
    sddm \
    sudo \
    vlc \
    xf86-input-vmmouse \
    xf86-video-vmware \
    xorg-server \
    zsh \
    zsh-syntax-highlighting

# Install yaourt
curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz
tar -xvzf package-query.tar.gz
cd package-query
makepkg -si
cd ..
curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
tar -xvzf yaourt.tar.gz
cd yaourt
makepkg -si

# Install packages from the AUR
yaourt \
    google-chrome \
    jdk \
    oh-my-zsh-git \
    samsung-unified-driver \
    spotify
