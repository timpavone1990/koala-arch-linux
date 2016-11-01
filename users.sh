# Set root password
passwd

# Create user tim
useradd \
    # Create home directory
    -m
    # Save full name in the comment
    -c "Tim Gremplewski" \
    # Set zsh as default shell
    -s /usr/bin/zsh \
    # Add tim to sudoers group
    -G wheel \
    # Login name
    tim

# Set password for user tim
passwd tim

cp tim.zshrc /home/tim/.zshrc
cp tim.zlogin /home/tim/.zlogin
cp .fonts.conf /home/tim/
cp tim.gitconfig /home/tim/.gitconfig

# Create user gremplewski
useradd \
    # Create home directory
    -m
    # Save full name in the comment
    -c "Tim Gremplewski" \
    # Set zsh as default shell
    -s /usr/bin/zsh \
    # Add gremplewski to sudoers group
    -G wheel \
    # Login name
    gremplewski

# Set password for gremplewski
passwd gremplewski
