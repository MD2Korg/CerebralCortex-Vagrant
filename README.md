
# Vagrant configuration for developing and testing Cerebral Cortex
This repository is ideal for developers and engineers to install and test Cerebral Cortex

This configuration has been developed and testing on Ubuntu 17.04 and these instructions reflect this environment.

Install dependencies and Vagrant
```
$ sudo apt get install virtualbox virtualbox-dkms virtualbox-guest-additions-iso

$ wget https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_x86_64.deb
$ sudo dpkg -Uvh vagrant_2.0.1_x86_64.deb
```

Install the docker-compose plugin for Vagrant
```
$ vagrant plugin install vagrant-docker-compose
```

Clone this repository and launch Cerebral Cortex.  Note: Vagrant must be run as superuser to properly forward ports
```
$ git clone https://github.com/MD2KOrg/CerebralCortex-Vagrant
$ sudo vagrant up
```

Once this process is complete, you should get a `Username/Password Authentication Failed` response confirming that the system is online.
```
$ wget http://localhost/api/v1/auth/
--2017-12-21 21:14:20--  http://localhost/api/v1/auth/
Resolving localhost (localhost)... 127.0.0.1
Connecting to localhost (localhost)|127.0.0.1|:80... connected.
HTTP request sent, awaiting response... 401 UNAUTHORIZED

Username/Password Authentication Failed.
```