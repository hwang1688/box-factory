# Install VMware Tools
printf "Installing VMware tools...\n"
cd /tmp
mkdir -p /mnt/cdrom
mount -o loop /home/sbadmin/linux.iso /mnt/cdrom
tar zxvf /mnt/cdrom/VMwareTools-*.tar.gz -C /tmp/
/tmp/vmware-tools-distrib/vmware-install.pl -d
rm /home/sbadmin/linux.iso
umount /mnt/cdrom
