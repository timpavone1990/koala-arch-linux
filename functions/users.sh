function createUser() {
    useradd --create-home \
            --user-group \
            --comment "$1" \
            --shell /usr/bin/zsh \
            --groups wheel \
            $2

    echo "Please enter a password for user '$2'"
    passwd $2

    chown --recursive \
          $2:$2 \
          $CONFIGURATION_FILES_DIR/$2

    find $CONFIGURATION_FILES_DIR/$2 \
         -type d \
         -exec chmod 775 {} \;

    find $CONFIGURATION_FILES_DIR/$2 \
         -type f \
         -exec chmod 664 {} \;

    cp --recursive \
       --archive \
       $CONFIGURATION_FILES_DIR/$2/. \
       /home/$2
}

function enableSudoForGroupWheel() {
    sed --in-place \
        '/^# %wheel.*(ALL) ALL$/ s/^# //' \
        /etc/sudoers
}

function setRootPassword() {
    echo "Please enter a password for user 'root'"
    passwd
}
