# Box Factory Project

## Introduction
This project is to demonstrate how to use Packer and Ansible to automate the build of VMware VMs with
different packages installed in each VM. The build system is using Gradle. Packer and Ansible local are 
used to build and provision the VMs.

## Tools & Ingredients
* A Mac with OS X El Capitan 10.11.6
* VMware Fusion Professional Version 8.5.3
* Gradle 3.4 installed with `brew install gradle`
* Packer 0.12.2 installed with `brew install packer`

## Instructions
Build Bare Box
```sh
$ gradle buildBareBox
```

Build JALPT Box
```sh
$ gradle buildJalptBox
```

Build Jenkins Box
```sh
$ gradle buildJenkinsBox
```

To clean up the output directory `build`
```sh
$ gradle clean
```

To clean up the output directory `build` and the Packer cache directory `packer_cache`, run
```sh
$ gradle cleanAll
```
The packer_cache directory holds the downloaded Debian iso file so that it doesn't need to 
retrieve it every time you build.

## Outcome

### Bare Box ###
A VMware VM named `bare` in the `build/bare` directory with these:
* 1 CPU, 1GB memory, 5GB disk
* Debian Linux 8.7.1
* Additional Debian packages:
  + curl
  + tree
  + sysstat
  + ansible

### JALPT (Java Apache Linux Postgres Tomcat) Box ###
A VMware VM named `jalpt` in the `build/jalpt` directory with these on it:
* 1 CPU, 2GB memory, 10GB disk
* Debian Linux 8.7.1
* Additional Debian packages:
  + curl
  + tree
  + sysstat
  + ansible
* PostgreSQL 9.4.10
* Oracle JDK 1.8.0_121-b13
* Apache2 2.4.10-10+deb8u7
* Tomcat 8.5.11
* Open ports with iptables: 22, 80, 443

### Jenkins Box ###
A VMware VM named `jenkins` in the `build/jenkins` directory with these on it:
* 1 CPU, 1GB memory, 10GB disk
* Debian Linux 8.7.1
* Additional Debian pakcages:
  + curl
  + tree
  + sysstat
  + ansible
* Oracle JDK 1.8.0_121-b13
* Apache2 2.4.10-10+deb8u7
* Jenkins 2.32.3
* Build tools for Jenkins:
  + git
  + docker
* Open ports with iptables: 22, 80, 443
