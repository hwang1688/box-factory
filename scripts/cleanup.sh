# Clean up
printf "Running: apt-get -y autoremove\n"
apt-get -y autoremove

printf "Running: apt-get -y clean\n"
apt-get -y clean

# Removing leftover leases and persistent rules
printf "Cleaning up dhcp leases..."
rm -f /var/lib/dhcp/*

