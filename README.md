# Sandbox Server Project

## Introduction
This project is to demonstrate how to use Packer and Ansible to automate the build of 2 VMware VMs with
different packages installed in each VM. The build system is using Gradle. Packer and Ansible local are 
used to build and provision the VMs.

## Tools & Ingredients
* A Mac with OS X El Capitan 10.11.6
* VMware Fusion Professional Version 8.5.3
* Gradle 3.4 installed with `brew install gradle`
* Packer 0.12.2 installed with `brew install packer`

## Instructions
Build Sanbox server
```sh
$ gradle buildSandbox
```

Build Jenkins server
```sh
$ gradle buildJenkins
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

### Sanbox Server ###
A VMware VM named `sandbox` in the `build/sandbox` directory with these on it:
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

### Jenkins Server ###
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
* Open ports with iptables: 22, 80, 443
