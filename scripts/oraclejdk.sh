# Install Oracle JDK
printf "Setting up apt source list for Oracle Java 8..."
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" > /etc/apt/sources.list.d/java-8-debian.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/java-8-debian.list
cat /etc/apt/sources.list.d/java-8-debian.list

printf "Running: apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886\n"
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886

printf "Running: apt-get -y update\n"
apt-get -y update

# The 2 lines below is to automatically accept the Oracle agreement
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections

printf "Running: apt-get -y install oracle-java8-installer\n"
apt-get -y install oracle-java8-installer

printf "Running: apt-get -y install oracle-java8-set-default\n"
apt-get -y install oracle-java8-set-default
