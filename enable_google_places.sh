#!/bin/bash
echo "apikeys:
  googleplacesapi: $1" >> /home/vagrant/CerebralCortex-DockerCompose/cc_config_file/cc_vagrant_configuration.yml

echo "Key updated successfully, please do not execute this command again to avoid corruption of the configuration."
