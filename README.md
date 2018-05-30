# Vagrant configuration for installing Cerebral Cortex
This repository is ideal for developers and engineers to install and evaluate the Cerebral Cortex platform.


# Disclaimer
This software is intended for informational and demonstration purposes only and is not designed to diagnose, treat, cure, prevent, or track disease or health states. No content provided in this software is intended to serve as a substitute for any kind of professional (e.g., medical) advice.

# Installation Instructions
The Cerebral Cortex platform can installed and tested on any of the three major platforms: Linux, Mac OS X, and Windows.  The following instructions will walk you through installing the dependencies necessary to run Cerebral Cortex.

## Linux: (Ubuntu 17.10)
These steps are preformed from the command line and do not need a graphical interface.

1. Install VirtualBox and Vagrant
  ```bash
  sudo apt install virtualbox virtualbox-dkms virtualbox-guest-additions-iso
  wget https://releases.hashicorp.com/vagrant/2.1.1/vagrant_2.1.1_x86_64.deb
  sudo dpkg -i vagrant_2.1.1_x86_64.deb
  ```

2. Install the docker-compose plugin for Vagrant

  ```bash
  vagrant plugin install vagrant-docker-compose
  vagrant plugin install vagrant-vbguest
  ```
  Please consult [Vagrant Documentation](https://www.vagrantup.com/docs/)  if you face any installation errors for step 1 and 2.

3. Clone this CerebralCortex-Vagrant repository.
  ```bash
  git clone https://github.com/MD2KOrg/CerebralCortex-Vagrant -b personal
  cd CerebralCortex-Vagrant
  vagrant up
  ```

## Mac OS X:
These steps are preformed from the command line with the support of [Homebrew](https://brew.sh/) and do not need a graphical interface.

1. Install VirtualBox and Vagrant
  ```bash
  brew cask install virtualbox
  brew cask install vagrant
  ```

2. Install the docker-compose plugin for Vagrant
  ```bash
  vagrant plugin install vagrant-docker-compose
  vagrant plugin install vagrant-vbguest
  ```
  Please consult [Vagrant Documentation](https://www.vagrantup.com/docs/)  if you face any installation errors for step 1 and 2.

3. Clone this CerebralCortex-Vagrant repository.
  ```bash
  git clone https://github.com/MD2KOrg/CerebralCortex-Vagrant -b personal
  cd CerebralCortex-Vagrant
  vagrant up
  ```

## Windows 7+:

1. Install VirtualBox and Vagrant
  - Download and install the Windows binary for VirtualBox: https://www.virtualbox.org/wiki/Downloads
  - Download and install the Windows binary for Vagrant: https://www.vagrantup.com/downloads.html


2. Install the docker-compose plugin for Vagrant by running the Windows command line: `cmd.exe`
  ```bash
  vagrant plugin install vagrant-docker-compose
  vagrant plugin install vagrant-vbguest
  ```
  Please consult [Vagrant Documentation](https://www.vagrantup.com/docs/)  if you face any installation errors for step 1 and 2.

3. Download or clone this CerebralCortex-Vagrant repository.  
  Download location: https://github.com/MD2Korg/CerebralCortex-Vagrant/archive/personal.zip

  or clone from Git if installed
  ```bash
  git clone https://github.com/MD2KOrg/CerebralCortex-Vagrant -b personal
  ```

  Finally, start the installation process.
  ```bash
  cd CerebralCortex-Vagrant
  vagrant up
  ```

## Remaining Installation Steps Common to All Operating Systems:

Confirm that everything started up correctly. The following commands lists the the status of all the services used by CerebralCortex.  Docker-Compose commands can be used to
interact with Cerebral Cortex's containers.

```bash
vagrant ssh
cd CerebralCortex-DockerCompose/
docker-compose ps
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

  ```bash
  vagrant ssh
  enable_google_places.sh COPY_KEY_HERE
  ```

#### Import and analyze the data
Data can now be processed, which can take some time due to the CPU intensive nature of computing all the features and markers.
  ```bash
  vagrant ssh
  ingest_and_analyze.sh
  ```

A large number of console logs will appear on the screen indicating what the system is currently doing.  It will first preprocess the data files you copied from the mCerebrum app into a format that Cerebral Cortex will ingest.  Next, the ingestion pipeline will scan and import this data into Cerebral Cortex's internal data stores.  Finally, it will run a pre-specified set of feature computations based on the smartphone sensors streams.


# Visualizing and Analyzing Your Data
Cerebral Cortex provides two mechanisms to visualize and analyze your data.  First, a user-centric interface is provided by the [Grafana](https://grafana.com/) project which can be utilized to plot and explore Cerebral Cortex data streams.  Second, a code-centric interface is provided by the [Jupyter](http://jupyter.org/) project and allows a user to write Python3 code to interact with the Cerebral Cortex kernel.

## Visualization of data with Grafana
Open this link in your web browser [http://localhost:8080/grafana](http://localhost:8080/grafana) to visualize your data.  

1. The default login and password are both `admin`.  

  ![Grafana](imgs/grafana.png)


2. Once you authenticate, you will see the following screen.

  ![Grafana Main](imgs/grafana-main.png)

3. Select the `Home` dropdown at the top left of the screen and choose the **MD2K_DEMO** dashboard.

  ![Grafana Visualization](imgs/grafana-main-dashboard.png)


This is a pre-built visualization that provides some examples of the various types of displays that are possible.  

For example, ... (TWH Complete this with data)
- Data Yield of MSHRV-LED, MSHRV-Accel, AutoSenseBLE
- Geolocation
- Phone/SMS/Notifications
- Phone screen touches

You may [create additional dashboards](http://docs.grafana.org/guides/getting_started/) to visualize all of the raw and processed data.


## Analyzing your data with Jupyter Notebooks
__Description needed__
If you want to write code and scripts to analyze and process your data.
Link to Getting started with Jupyter notebook tutorials

Open this link in your web browser [http://localhost:8080/jupyterhub/hub/login](http://localhost:8080/jupyterhub/hub/login) to interact and analyze your data.  

1. A login screen will be shown as follows.  

  The username and password are both `md2k`.  The warning shown is because this site is running locally on your machine and is not secured by a security certificate.  There is no data leaving the machine and going across the internet.

  ![Jupyter Hub](imgs/jupyter.png)

2. A file browser will appear after successful authentication and you should choose the `cc_demo` folder.

  ![Jupyter Files](imgs/jupyter-files.png)

  ![Jupyter Demo](imgs/jupyter-demo.png)

3. Click on the `CerebralCortex_Basic_Usage.ipynb` and it will open in a new tab.  This provides an overview of how to utilize Cerebral Cortex and visualize some data.

  ![Jupyter Cerebral Cortex Demo](imgs/jupyter-CC-demo.png)

This example notebook demonstrates the following:
  - Import CerebralCortex libraries and loading configurations
  - Get all users of a study
  - Get all streams of a user
  - Get days when a stream has data available
  - Get a stream's raw data and metadata
  - Plot stream raw data


### Creating your own scripts

  1. Authenticate with user credentials
  2. Click on Files tab
  3. Click on new and select `pySpark (Spark 2.2.0) (Python 3)` to create a new Python script.



## Computing features
The [CerebralCortex-DataAnalysis](https://github.com/MD2Korg/CerebralCortex-DataAnalysis) repository is available within the Vagrant virtual machine.  This repository contains the code to compute features on the data. The repository contains a number of features in the `core/feature` directory.
The following features have been validated by us and that are what we believe is stable. The other features are still
under development. Please keep an lookout on this page for updates to stable features.
* phone_features
* gpsfeature
* puffmarker
* rr_interval

`Simple_driver.ipynb` provides an example to execute features contained in the CerebralCortex-DataAnalysis repository.

Please have a look at the documentation for each of the above features to get more insight into their functionality.

#### Sensors needed for the different features
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
```bash
vagrant halt
```

Suspend Cerebral Cortex
```bash
vagrant suspend
```

Start Cerebral Cortex
```bash
vagrant up
```


## FAQ

1. **I'm stuck, where do I get help?**

  Please look for more information or ask for help here: [https://discuss.md2k.org/](https://discuss.md2k.org/)

2. **System requirements**

  These are the minimum recommended system requirements for running Cerebral Cortex.
  - 2-4 core CPU
  - 16+ GB RAM
  - 10GB disk + enough to support the total data collection from mCerebrum


3. **Errors encountered during provisioning**

  Use `vagrant up --provision` to resume the installation.
