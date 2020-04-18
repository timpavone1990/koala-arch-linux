function partitionDisk() {
    parted --script \
           --align optimal \
           /dev/sda \
           mklabel gpt \
           mkpart primary 2048s 4095s \
           set 1 bios_grub on \
           name 1 "'BIOS boot partition'" \
           mkpart primary ext4 4096s 100% \
           set 2 lvm on \
           name 2 system

    pvcreate /dev/sda2
    vgcreate vg1 /dev/sda2
    lvcreate --extents 98%VG \
             --name system \
             vg1

    mkfs.ext4 -L system \
              /dev/vg1/system

    mount /dev/vg1/system /mnt/

    lvcreate --extents 100%FREE \
             --name swap \
             vg1

    mkswap /dev/vg1/swap
    swapon /dev/vg1/swap
}
