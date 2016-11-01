# Create mount points
mkdir -p /mnt/mnt/Daten
mkdir -p /mnt/mnt/Windows
mkdir -p /mnt/mnt/Homes/tim
mkdir -p /mnt/mnt/Share

# Generate fstab using UUIDs
genfstab -U /mnt >> /mnt/etc/fstab
echo ".host:/Daten /mnt/Daten fuse.vmhgfs-fuse defaults,allow_other 0 0" >> /mnt/etc/fstab
echo ".host:/Windows /mnt/Windows fuse.vmhgfs-fuse defaults,allow_other 0 0" >> /mnt/etc/fstab
echo "192.168.0.9:/mnt/FatLady/Shared\040Folders /mnt/Share/ nfs noauto,retry=0,rw,soft,user 0 0" >> /mnt/etc/fstab
echo "192.168.0.9:/mnt/FatLady/User\040Folders/tim /mnt/Homes/tim/ nfs noauto,retry=0,rw,soft,user 0 0" >> /mnt/etc/fstab
