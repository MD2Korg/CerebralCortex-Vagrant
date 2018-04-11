
# Vagrant configuration for developing and testing Cerebral Cortex
This repository is ideal for developers and engineers to install and test
Cerebral Cortex

This configuration has been developed and testing on Ubuntu 17.04 and these
instructions reflect this environment.

Install dependencies and Vagrant
```
$ sudo apt install virtualbox virtualbox-dkms virtualbox-guest-additions-iso

$ wget https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_x86_64.deb
$ sudo dpkg -i vagrant_2.0.1_x86_64.deb
```

Install the docker-compose plugin for Vagrant
```
$ sudo vagrant plugin install vagrant-docker-compose
$ sudo vagrant plugin install vagrant-vbguest
```

Clone this repository and launch Cerebral Cortex.  Note: Vagrant must be run as superuser to properly forward ports
```
$ git clone https://github.com/MD2KOrg/CerebralCortex-Vagrant -b 2.2.2
$ cd CerebralCortex-Vagrant
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


## Starting and stopping Cerebral Cortex

Start Cerebral Cortex
```
$ sudo vagrant up
```

Stop Cerebral Cortex
```
$ sudo vagrant halt
```

Suspend Cerebral Cortex
```
$ sudo vagrant suspend
```

Access Cerebral Cortex's console.  Docker-Compose commands can be used to
interact with Cerebral Cortex's containers.
```
$ sudo vagrant ssh
Last login: Fri Dec 22 03:01:17 2017 from 10.0.2.2
[vagrant@cerebralcortex ~]$ cd CerebralCortex-DockerCompose/
[vagrant@cerebralcortex CerebralCortex-DockerCompose]$ docker-compose ps
     Name                    Command               State                                      Ports
---------------------------------------------------------------------------------------------------------------------------------------
md2k-api-server   /entrypoint.sh /start.sh         Up      443/tcp, 80/tcp
md2k-cassandra    /bootstrap.sh cassandra -f       Up      7000/tcp, 7001/tcp, 7199/tcp, 0.0.0.0:9042->9042/tcp, 0.0.0.0:9160->9160/tcp
md2k-grafana      /run.sh                          Up      0.0.0.0:3000->3000/tcp
md2k-influxdb     /entrypoint.sh influxd           Up      0.0.0.0:8086->8086/tcp
md2k-jupyterhub   jupyterhub --no-ssl --conf ...   Up
md2k-kafka        start-kafka.sh                   Up      0.0.0.0:9092->9092/tcp
md2k-minio        /usr/bin/docker-entrypoint ...   Up      0.0.0.0:9000->9000/tcp
md2k-mysql        docker-entrypoint.sh mysqld      Up      0.0.0.0:3306->3306/tcp
md2k-nginx        nginx -g daemon off;             Up      0.0.0.0:443->443/tcp, 0.0.0.0:80->80/tcp
md2k-zookeeper    /bin/sh -c /usr/sbin/sshd  ...   Up      0.0.0.0:2181->2181/tcp, 22/tcp, 2888/tcp, 3888/tcp
```

## Running test cases
Run system level test-cases to make sure all the things are setup properly.
```
cd /home/vagrant/CerebralCortex/cerebralcortex/core/test_suite/
python3.6 -m unittest discover
```

## Importing data
The
`/home/vagrant/CerebralCortex-DockerCompose/cc_config_file\cc_vagrant_configuration.yml`
contains the parameter that stores the path from where data can be imported into 
CerebralCortex

Copy data into the directory used in the configuraton file.
```
cd /home/vagrant/CerebralCortex-DockerCompose/data/
wget https://mhealth.md2k.org/images/datasets/mCerebrum_test_data.tar.bz2
tar -xf mCerebrum_test_data.tar.bz2
rm -f mCerebrum_test_data.tar.bz2
```

Import the data into CerebralCortex
```
cd /home/vagrant/CerebralCortex-Scripts/data_replay/
python3.6 store_dirs_to_db.py --conf
/home/vagrant/CerebralCortex-DockerCompose/cc_config_file/cc_vagrant_configuration.yml

cd /home/vagrant/CerebralCortex-KafkaStreamPreprocessor/
sudo sh run_vagrant.sh

```
## Using mCerebrum

Download the latest mCerebrum from [https://github.com/MD2Korg/mCerebrum-releases/tree/master/2.0/org.md2k.mcerebrum](https://github.com/MD2Korg/mCerebrum-releases/tree/master/2.0/org.md2k.mcerebrum)

Login to the mCerebrum application with the following information:
* Login: string
* Password: string
* Server: http://YOUR_MACHINE_IP_OR_DNS_NAME/

Once the system successfully authenticates, it will download a predefined
configuration file for you to test our the platform.  Once `Start Study` is
pressed the system will begin collecting and uploading to this enviornment.

## Removing Vagrant image of CC
Run following commands if anything goes wrong and/or you want to uninstall CerebralCortex vagrant image
```
sudo vagrant global-status
Find the IMAGE-NAME. It would be required for next command
sudo vagrant destroy  IMAGE-NAME
```
