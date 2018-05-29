# Vagrant configuration for installing Cerebral Cortex
This repository is ideal for developers and engineers to install and evaluate the Cerebral Cortex platform.


# Disclaimer
This software is intended for informational and demonstration purposes only and is not designed to diagnose, treat, cure, prevent, or track disease or health states. No content provided in this software is intended to serve as a substitute for any kind of professional (e.g., medical) advice.

# Installation Instructions
The Cerebral Cortex platform can installed and tested on any of the three major platforms: Linux, Mac OS X, and Windows.  The following instructions will walk you through installing the dependencies necessary to run Cerebral Cortex.

## Linux: (Ubuntu 17.10)
These steps are preformed from the command line and do not need a graphical interface.

1. Install VirtualBox and Vagrant
  ```
  $ sudo apt install virtualbox virtualbox-dkms virtualbox-guest-additions-iso
  $ wget https://releases.hashicorp.com/vagrant/2.1.1/vagrant_2.1.1_x86_64.deb
  $ sudo dpkg -i vagrant_2.1.1_x86_64.deb
  ```

2. Install the docker-compose plugin for Vagrant

  ```
  $ vagrant plugin install vagrant-docker-compose
  $ vagrant plugin install vagrant-vbguest
  ```
  Please consult [Vagrant Documentation](https://www.vagrantup.com/docs/)  if you face any installation errors for step 1 and 2.

3. Clone this CerebralCortex-Vagrant repository.
  ```
  $ git clone https://github.com/MD2KOrg/CerebralCortex-Vagrant -b 2.2.2.personal
  $ cd CerebralCortex-Vagrant
  $ vagrant up
  ```

## Mac OS X:
These steps are preformed from the command line with the support of [Homebrew](https://brew.sh/) and do not need a graphical interface.

1. Install VirtualBox and Vagrant
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

3. Clone this CerebralCortex-Vagrant repository.
  ```
  $ git clone https://github.com/MD2KOrg/CerebralCortex-Vagrant -b 2.2.2.personal
  $ cd CerebralCortex-Vagrant
  $ vagrant up
  ```

## Windows 10:

1. Install VirtualBox and Vagrant
  - Download and install the Windows binary for VirtualBox: [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)
  - Download and install the Windows binary for Vagrant: [https://www.vagrantup.com/downloads.html](https://www.vagrantup.com/downloads.html)

2. Install the docker-compose plugin for Vagrant by running the Windows command line: `cmd.exe`
  ```
  $ vagrant plugin install vagrant-docker-compose
  $ vagrant plugin install vagrant-vbguest
  ```
  Please consult [Vagrant Documentation](https://www.vagrantup.com/docs/)  if you face any installation errors for step 1 and 2.

3. Download or clone this CerebralCortex-Vagrant repository.  
  Download location: [https://github.com/MD2Korg/CerebralCortex-Vagrant/archive/2.2.2.personal.zip](https://github.com/MD2Korg/CerebralCortex-Vagrant/archive/2.2.2.personal.zip)

  or clone from Git if installed
  ```
  $ git clone https://github.com/MD2KOrg/CerebralCortex-Vagrant -b 2.2.2.personal
  ```

  Finally, start the installation process.
  ```
  $ cd CerebralCortex-Vagrant
  $ vagrant up
  ```

## Remaining Installation Steps Common to All Operating Systems:

1. Confirm that everything started up correctly.

  The following commands lists the the status of all the services used by CerebralCortex.  Docker-Compose commands can be used to
  interact with Cerebral Cortex's containers.
  ```
  $ vagrant ssh
  $ cd CerebralCortex-DockerCompose/
  $ docker-compose ps
  ```

  The above commands display the status of all the services as shown below.
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

2. Optional: Run Cerebral Cortex Test Cases
  You can run system level test-cases to make sure all components are setup and running properly. System level test cases will generate some sample data, process it using Cerebral Cortex, store it, retrieve it and verify results with predefined test values.
  ```
  $ vagrant ssh
  $ cd /home/vagrant/CerebralCortex/cerebralcortex/core/test_suite/
  $ python3.6 -m unittest discover
  ```

## Importing and Analyzing Your Data

### Downloading mCerebrum data to your computer

1. **Important**: You must first stop data collection before connecting the smartphone to a computer.

2. Connect the smartphone to a PC using the charging cable.

  ![mCerebrum Computer Interface](imgs/phone2computer.png)

3. Using the computer, navigate to the phone’s org.md2k.mCerebrum folder. `Phone > Android > data > org.md2k.mCerebrum > files > 636fcc1f-8966-4e63-a9df-0cbaa6e9296c`

  ![mCerebrum Data Folder](imgs/mCerebrum_data_folder.png)

4. Copy all of the `*.gz` and `*.json` files to `PATH/TO/CerebralCortex-Vagrant/data/raw`

  ![mCerebrum to Cerebral Cortex](imgs/mCerebrum_to_cerebral_cortex.png)

5. Disconnect the smartphone from the computer


### Importing and processing your data

Some of the features that can be computed rely on the Google Places API and if you would like to include this optional capability, the following steps are required to configure this option.

#### Enable Google Places API

1. Navigate to [https://developers.google.com/](https://developers.google.com/) and sign in with a valid Google account.

2. Navigate to the places web-service `Get API Key` page [https://developers.google.com/places/web-service/get-api-key](https://developers.google.com/places/web-service/get-api-key)

3. Follow the steps to `Get A Key` for the __standard Places API for Web__ option. By default, the key is good for 1000 queries/day and can be increased to 150k/day by verifying your identity with a credit card.

4. Run the following command to enable the location-aware features in the Cerebral Cortex pipeline.

  ```
  $ vagrant ssh
  $ enable_google_places.sh COPY_KEY_HERE
  ```

#### Import and analyze the data
Data can now be processed, which can take some time due to the CPU intensive nature of computing all the features and markers.
  ```
  $ vagrant ssh
  $ ingest_and_analyze.sh
  ```

A large number of console logs will appear on the screen indicating what the system is currently doing.  It will first preprocess the data files you copied from the mCerebrum app into a format that Cerebral Cortex will ingest.  Next, the ingestion pipeline will scan and import this data into Cerebral Cortex's internal data stores.  Finally, it will run a pre-specified set of feature computations based on the smartphone sensors streams.


# Visualizing and Analyzing Your Data

## Visualization of data with Grafana
Open this link in your web browser [http://localhost/grafana](http://localhost/grafana) to visualize your data

- Data Yield of MSHRV-LED, MSHRV-Accel, AutoSenseBLE
- Geolocation
- Phone/SMS/Notifications
- Phone screen touches

This is the sample dashboard, you may [create aditional dashboards](http://docs.grafana.org/guides/getting_started/) to visualize all of the sensors' raw data.


## Analyzing your data with Jupyter Notebooks
__Description needed__
If you want to write code and scripts to analyze and process your data.
Link to Getting started with Jupyter notebook tutorials


You may access Python Jupyter Notebook interface at:
```
http://localhost/jupyterhub/hub/login
```

Default user for Jupyter notebook is
```
User Name: md2k
Password: md2k
```
Jupyter Notebook has cc_demo folder that contains sample script. Demo script shows some example on how to use CerebralCortex API to interact with data:

To create new python script:
```
Authenticate with user credentials
Click on Files tab
Click on new and select pySpark (Spark 2.2.0) (Python 3) to create a new Python script.
```

### Interacting CerebralCortex using Jupyter
The Jupyter notebook contains ```cc_demo/CerebralCortex_Basic_Usage.ipynb``` that has basic examples on how to:

- Import CerebralCortex libraries and loading configurations
- Get all users of a study
- Get all streams of a user
- Get days when a stream has data available
- Get a stream's raw data and metadata
- Plot stream raw data

### Computing features
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
vagrant global-status
Find the IMAGE-NAME. It would be required for next command
vagrant destroy  IMAGE-NAME
```



## Starting and stopping Cerebral Cortex
Stop Cerebral Cortex
```
$ vagrant halt
```
Suspend Cerebral Cortex
```
$ vagrant suspend
```
Start Cerebral Cortex
```
$ vagrant up
```


## FAQ

1. **I'm stuck, where do I get help?**
Please look for more information or ask for help here: [https://discuss.md2k.org/](https://discuss.md2k.org/)

2. **System requirements**


3. **Possible errors that can be encountered during the installation.**
```
Pulling grafana (grafana/grafana:latest)...
Get https://registry-1.docker.io/v2/: dial tcp: lookup registry-1.docker.io on
10.0.2.3:53: read udp 10.0.2.15:34893->10.0.2.3:53: i/o timeout
```
The above error is DockerCompose error, please restart initializing the VM with
the following command.
```
vagrant up --provision
```

4. **Errors encountered during provisioning**
Use `sudo vagrant up --provision` to resume the installation.
