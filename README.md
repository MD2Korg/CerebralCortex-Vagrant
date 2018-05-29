# Vagrant configuration for installing Cerebral Cortex
This repository is ideal for developers and engineers to install the Cerebral Cortex framework.


# Disclaimer
Text from Shahin

## Linux: Ubuntu 17.10.

1. To install Vagrant and dependencies
```
$ sudo apt install virtualbox virtualbox-dkms virtualbox-guest-additions-iso

$ wget https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_x86_64.deb
$ sudo dpkg -i vagrant_2.0.1_x86_64.deb
```

2. Install the docker-compose plugin for Vagrant
```
$ sudo vagrant plugin install vagrant-docker-compose
$ sudo vagrant plugin install vagrant-vbguest
```
Please consult [Vagrant Documentation](https://www.vagrantup.com/docs/)  if you face any installation errors for step 1 and 2. 

3. Clone this CerebralCortex-Vagrant repository.  Note: Vagrant must be run as superuser to properly forward ports
```
$ git clone https://github.com/MD2KOrg/CerebralCortex-Vagrant -b 2.2.2.citizen_scientist
$ cd CerebralCortex-Vagrant
$ sudo vagrant up
```

## Mac OS X:

1. To install Vagrant and dependencies
```
$ brew cask install virtualbox

$ brew cask install vagrant
```

2. Install the docker-compose plugin for Vagrant
```
$ vagrant plugin install vagrant-docker-compose
$ vagrant plugin install vagrant-vbguest
```
Please consult [Vagrant Documentation](https://www.vagrantup.com/docs/)  if you face any installation errors for step 1 and 2. 

3. Clone this CerebralCortex-Vagrant repository.  Note: Vagrant must be run as superuser to properly forward ports
```
$ git clone https://github.com/MD2KOrg/CerebralCortex-Vagrant -b 2.2.2.citizen_scientist
$ cd CerebralCortex-Vagrant
$ sudo vagrant up
```

## Windows 10:

1. To install Vagrant and dependencies
  - Download and install the Windows binary for VirtualBox https://www.virtualbox.org/wiki/Downloads
  - Donwload and install the Windows binary for Vagrant https://www.vagrantup.com/downloads.html

2. Install the docker-compose plugin for Vagrant
```
$ vagrant plugin install vagrant-docker-compose
$ vagrant plugin install vagrant-vbguest
```
Please consult [Vagrant Documentation](https://www.vagrantup.com/docs/)  if you face any installation errors for step 1 and 2. 

3. Download or clone this CerebralCortex-Vagrant repository.  
```
$ git clone https://github.com/MD2KOrg/CerebralCortex-Vagrant -b 2.2.2.citizen_scientist
or
Download https://github.com/MD2Korg/CerebralCortex-Vagrant/archive/2.2.2.citizen_scientist.zip and unzip
```

```
$ cd CerebralCortex-Vagrant
$ sudo vagrant up
``

## Common: 

1. Confirm that everything started up correctly.

The following commands lists the the status of all the services used by CerebralCortex.  Docker-Compose commands can be used to
interact with Cerebral Cortex's containers.
1. sudo vagrant ssh
2. cd CerebralCortex-DockerCompose/
3. docker-compose ps
The above command displays the status of all the services as shown below. 
```
      Name                    Command               State                    Ports                   
 ---------------------------------------------------------------------------------------------------
 md2k-api-server   /entrypoint.sh /start.sh         Up      443/tcp, 80/tcp                          
 md2k-grafana      /run.sh                          Up      0.0.0.0:3000->3000/tcp                   
 md2k-influxdb     /entrypoint.sh influxd           Up      0.0.0.0:8086->8086/tcp                   
 md2k-jupyterhub   jupyterhub --no-ssl --conf ...   Up      0.0.0.0:32771->8000/tcp                  
 md2k-minio        /usr/bin/docker-entrypoint ...   Up      0.0.0.0:9000->9000/tcp                   
 md2k-mysql        docker-entrypoint.sh mysqld      Up      0.0.0.0:3306->3306/tcp                   
 md2k-nginx        nginx -g daemon off;             Up      0.0.0.0:443->443/tcp, 0.0.0.0:80->80/tcp
```

## Running test cases
Run system level test-cases to make sure all the things are setup properly. System level test case will generate some sample data, process it using CerebralCortex, store it, retrieve it and verify results with predefined test values.
```
cd /home/vagrant/CerebralCortex/cerebralcortex/core/test_suite/
python3.6 -m unittest discover
```

## Importing data
####TODO- UPDATE THIS, pluging the phone (MONOWAR)
The
`/home/vagrant/CerebralCortex-DockerCompose/cc_config_file\cc_vagrant_configuration.yml`
contains the parameter that stores the path from where data can be imported into 
CerebralCortex. All the paths are setup correctly to launch CerebralCortex.

Copy data into the directory used in the configuraton file.
```
cd CerebralCortex-Vagrant (on your host machine)
cd data/raw/

Copy all data in raw folder. Folder shall contain a pair of files 
(.gz file containing raw data, and .json file contain metadata of the file)
All data shall be in one folder. This folder shall not contain other folders.  
```

Import the data into CerebralCortex
```
cd /home/vagrant/CerebralCortex-Scripts/data_replay/
sudo sh scan_vagrant_dir.sh

cd /home/vagrant/CerebralCortex-KafkaStreamPreprocessor/
sudo sh run_vagrant.sh

```

## Using Jupyter notebook
You may access Python Jupyter Notebook interface at:
```
http://localhost/jupyterhub/hub/login
```

Default user for Jupyter notebook is
```
User Name: md2k
Password: mdk2
```
Jupyter Notebook has cc_demo folder that contains sample script. Demo script shows some example on how to use CerebralCortex API to interact with data:

To create new python script:
```
Authenticate with user credentials
Click on Files tab
Click on new and select pySpark (Spark 2.2.0) (Python 3) to create a new Python script.
```

## Computing features
The Jupyter notebook environment also contains the [CerebralCortex-DataAnalysis](https://github.com/MD2Korg/CerebralCortex-DataAnalysis) repository. 
This repository contains the code to compute features on the data. The repository contains a number of features in the `core/feature` directory.
The following features have been validated by us and that are what we believe is stable. The other features are still
under development. Please keep an lookout on this page for updates to stable features.
* phone_features
* gpsfeature
* puffmarker
* rr_interval

`Simple_driver.ipynb` provides an example to execute features contained in the CerebralCortex-DataAnalysis repository.

Please have a look at the documentation for each of the obove features to get more insight into their functionality.

#### Senors needed for the different features
The `phone_features` and the `gpsfeature` can be computed from the data by your phone. The `puffmarker` and the `rr_interval`
require the data from the wrist worn MotionsenseHRV sensor.

#### Feature dependencies
To execute `gpsfeature`, `gps` must first be computed and then `gps_daily` must be computed.

 

## Increasing the available disk space in VM
Edit the Vagrant file to add the following line.
```
config.vm.synced_folder "<host_machine_folder_path>", "<foder_path_in_VM>"
```
This will mount a folder from the host machine in the VM. 

## Removing Vagrant image of CC
Run following commands if anything goes wrong and/or you want to uninstall CerebralCortex vagrant image
```
sudo vagrant global-status
Find the IMAGE-NAME. It would be required for next command
sudo vagrant destroy  IMAGE-NAME
```
## Starting and stopping Cerebral Cortex
When you are done using stop as
PUT THIS IN THE END
to resume
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

## FAQ
1. **System requirements**


2. **Possible errors that can be encountered during the installation.**
```
Pulling grafana (grafana/grafana:latest)...
Get https://registry-1.docker.io/v2/: dial tcp: lookup registry-1.docker.io on
10.0.2.3:53: read udp 10.0.2.15:34893->10.0.2.3:53: i/o timeout
```
The above error is DockerCompose error, please restart initializing the VM with
the following command.
```
sudo vagrant up --provision
```

3. **Errors encountered during provisioning**
Use `sudo vagrant up --provision` to resume the installation.

