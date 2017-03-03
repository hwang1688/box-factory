# Update the box
printf "Running: apt-get -y update\n"
apt-get -y update

printf "Running: apt-get -y upgrade\n"
apt-get -y upgrade

# Install ansible
printf "Running: apt-get -y install ansible\n"
apt-get -y install ansible
