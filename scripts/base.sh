# Update the box
printf "Running: apt-get -y update\n"
apt-get -y update

# Install curl
printf "Running: apt-get -y install curl\n"
apt-get -y install curl

# Install tree
printf "Running: apt-get -y install tree\n"
apt-get -y install tree

# Install ansible
printf "Running: apt-get -y install ansible\n"
apt-get -y install ansible

# Tweak sshd to prevent DNS resolution (speed up logins)
printf "Configure sshd to prevent DNS resolution...\n"
printf "\n#Prevent DNS resolution to speed up logins\nUseDNS no\n" >> /etc/ssh/sshd_config
cat /etc/ssh/sshd_config

# Remove 5s grub timeout to speed up booting
printf "Remove 5s grub timeout to speed up booting..."
cp -f /etc/default/grub /etc/default/grub.old
sed -e "s/^GRUB_TIMEOUT\=[0-9]*$/GRUB_TIMEOUT\=0/" /etc/default/grub.old > /etc/default/grub
cat /etc/default/grub
update-grub
rm -f /etc/default/grub.old
