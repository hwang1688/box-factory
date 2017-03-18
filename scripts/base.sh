# Update the box
printf "Running: apt-get -y update\n"
apt-get -y update

printf "Running: apt-get -y upgrade\n"
apt-get -y upgrade

# Install latest ansible
printf "Adding ansible to sources.list...\n"
cat <<EOF >> /etc/apt/sources.list

# For Ansible latest
deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main
EOF
cat /etc/apt/sources.list

printf "Running: apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367...\n"
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367

printf "Running: apt-get -y update\n"
apt-get -y update

printf "Running: apt-get -y install ansible\n"
apt-get -y install ansible
