# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "centos/7"
  # config.vm.box = "ubuntu/xenial64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  config.vm.network "forwarded_port", guest: 80, host: 80

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  machine_ip = "10.100.100.5"
  config.vm.network "private_network", ip: machine_ip

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"



  config.vm.hostname = "cerebralcortex"

  
  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
    # Customize the amount of memory on the VM:
    vb.memory = 8192
    vb.cpus = 4

    vb.name = "cerebralcortex"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Force CentOS/7 to turn on the second ethernet interface
  config.vm.provision "shell", inline: "ifup eth1", run: "always"
  
  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL


  config.vm.provision "shell", inline: <<-SHELL
    yum install -y git
    rm -rf CerebralCortex*
    git clone https://github.com/MD2Korg/CerebralCortex-DockerCompose
    git clone https://github.com/MD2Korg/CerebralCortex
    git clone https://github.com/MD2Korg/CerebralCortex-APIServer
  SHELL


  
  config.vm.provision :docker
  config.vm.provision :docker_compose, yml: "/home/vagrant/CerebralCortex-DockerCompose/docker-compose.yml", env: { "MACHINE_IP" => "#{machine_ip}" }, run: "always"

  # Temporary fix for mysql-apiserver startup problem
  config.vm.provision "shell", inline: <<-SHELL
    cd /home/vagrant/CerebralCortex-DockerCompose
    /usr/local/bin/docker-compose restart apiserver
  SHELL
  
  # config.vm.provision "docker" do |d|
  #   d.pull_images "hello-world"
  # end

end
