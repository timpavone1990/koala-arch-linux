# Enable dhcp client
systemctl enable dhcpcd.service

# Enable sddm
systemctl enable sddm

# Enable VMware tools
systemctl enable vmware-vmblock-fuse.service
