parted \
    # Non interactive mode
    -s \
    # Optimal alignment
    -a optimal \
    # Disk to partition
    /dev/sda \
    # Create a new GPT partition table
    mklabel gpt \
    # Create a bios boot partition
    mkpart primary 2048s 4095s \
    # Set partition type for the bios boot partition
    set 1 bios_grub on \
    # Set a name for the bios boot partition
    name 1 "'BIOS boot partition'" \
    # Create a primary partition
    mkpart primary ext4 4096s 100% \
    # Set the partition type to lvm for the main partition
    set 2 lvm on \
    # Set a name for the main partition
    name 2 system

# Create physical volume on the main partition
pvcreate /dev/sda2

# Create a volume group of the whole physical volume
vgcreate vg1 /dev/sda2

# Create a new main logical volume
lvcreate \
    # 98% of the whole volume group
    -l 98%VG \
    # Name system
    -n system \
    # Volume group to use
    vg1

# Create a file system on the main logical volume
mkfs.ext4 \
    # Label
    -L system \
    # Device
    /dev/vg1/system

# Create a new swap logical volume
lvcreate \
    # 100% of the space left in the volume group
    -l 100%FREE \
    # Name swap
    -n swap \
    # Volume group to use
    vg1

# Create a swap file system on the swap logical volume
mkswap /dev/vg1/swap

# Mount the main logical volume to /mnt
mount /dev/vg1/system /mnt

# Activate the swap logical volume in order to be detected later by genfstab
swapon /dev/vg1/swap
