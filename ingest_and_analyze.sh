#!/bin/bash

cd /home/vagrant/CerebralCortex-Scripts/data_replay/ && sh scan_vagrant_dir.sh

cd /home/vagrant/CerebralCortex-KafkaStreamPreprocessor/ && sh run_vagrant.sh

cd /home/vagrant/CerebralCortex-DataAnalysis/ && sh compute_vagrant_gps.sh

cd /home/vagrant/CerebralCortex-DataAnalysis/ && sh compute_vagrant_personal.sh



