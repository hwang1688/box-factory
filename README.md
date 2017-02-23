# Sandbox Server

## Tools & Ingredients
* A Mac with OS X El Capitan 10.11.6
* VMware Fusion Professional Version 8.5.3
* Packer installed with `brew install packer`

## Instructions
Build with Gradle
```sh
$ gradle
```

Or, run this commands to build directly with packer
```sh
$ packer build -force sandbox-server.json
```

To clean up the output directory `output-vmware-iso`, run
```sh
$ gradle clean
```

To clean up the output directory `output-vmware-iso` and the Packer cache directory `packer_cache`, run
```sh
$ gradle cleanAll
```

## Outcome
A VMware VM named `sandbox` in the `output-vmware-iso` directory with these on it:
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
