Vagrant.configure("2") do |config|
  config.vm.box = "md2k/cerebralcortex_personal"
  config.vm.box_version = "1.0.0"

  config.vm.network "forwarded_port", guest: 80, host: 8080
  machine_ip = "10.100.100.5"
  config.vm.network "private_network", ip: machine_ip

  config.vm.synced_folder "./vagrant_data", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
    # Customize the amount of memory on the VM:
    vb.memory = 8192
    vb.cpus = 4

    vb.name = "cerebralcortexpersonal"
  end

  # Force CentOS/7 to turn on the second ethernet interface
  config.vm.provision "shell", inline: "ifup eth1", run: "always"

  # Restart all services
  config.vm.provision "shell", run: "always", inline: <<-SHELL
    cd /home/vagrant/CerebralCortex-DockerCompose
    /usr/local/bin/docker-compose restart
  SHELL

end

