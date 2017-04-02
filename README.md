# Box Factory Project

## Introduction
This project is to demonstrate how to use Packer and Ansible to automate the build of VMware VMs with
different packages installed in each VM. The build system is using Gradle. Packer and Ansible local are 
used to build and provision the VMs.

## Tools & Ingredients
* A Mac with OS X El Capitan 10.11.6 with [Homebrew](https://brew.sh) installed to manage packages.
* [VMware Fusion](https://my.vmware.com/en/web/vmware/info/slug/desktop_end_user_computing/vmware_fusion/8_0)
  Professional Version 8.5.6
* [Gradle](https://gradle.org) 3.4.1 installed with `brew install gradle`
* [Packer](https://www.packer.io) 0.12.3 installed with `brew install packer`

## Instructions
Build Bare Box
```sh
$ gradle buildBareBox
```

Build JALP Box
```sh
$ gradle buildJalpBox
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

### JALP (Java Apache Linux Postgres) Box ###
A VMware VM named `jalp` in the `build/jalp` directory with these on it:
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
* Open ports with iptables: 22, 80, 443

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

# Where things are
## Source Directories
* `ansible` directory contains the Ansible playbooks and the files for all the roles used by Ansible Local
  to install needed files on the VMs. The playbooks are used by Packer's Ansible Local provisioner.
* `http` directory contains the configuration file used by Packer to initially setup the Debian Linux OS
  on the VM.
* `scripts` directory contains the shell scripts used by Packer's Shell provisioner.
* `templates` directory contains the Packer build template files for the OS. Current, only Debian Linux is provided.
* `varfiles` directory contains the override variables for Packer's template files for different VMs.

## Other Intermediate Directories
* `build` directory contains the uncompressed VM directories for the build, each VM has its own directory.
  This directory is specified in the Packer's template file.
* `packer_cache` directory holds the cached copy of the OS installation files so Packer doesn't need to download
  from the source every time.

# How it works

The VMs are built with Packer using Ansible Local option wrapped within Gradle. When a Gradle VM target is
invoked, it executes the Packer command line to build the VM and provision the VM using Packer's Ansible Local
provisioner. Here are the main steps using the Bare Box as an example:

1. Command `gradle buildBareBox` is executed.
2. Gradle executes `packer build -force -var-file=varfiles/bare.json templates/debian.json` is called.
3. Packer builds the VM, install the OS, and calls the `base.sh` script to install Ansible on the VM so it can
   be used in the next step.
4. Packer provisions the VM by using Ansible Local, shipper the Ansible playbook file `playbook-bare.yml` to
   the VM after it is up and running. Packer also uploads all the Ansible role files to the VM as well.
5. Ansible local runs `ansible-playbook -i localhost playbook-bare.yml` to provision the VM.
6. When Ansible deployment is completed, Packer calls the `cleanup.sh` script to clean up files left on the VM.
7. Packer then shuts down the VM and cleans up the VMware leftover files.
