#!/bin/bash

# Installs Docker CE
# https://docs.docker.com/install/linux/docker-ce/centos/
echo "INFO: Started Installing Docker..."

# Remove older versions
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

# Set up repo
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker
sudo yum install -y docker-ce docker-ce-cli containerd.io

# Start Docker and enable auto-start on boot
sudo systemctl start docker
sudo systemctl enable docker

# Check Docker status
sudo systemctl status docker

# Check Docker version (was "Docker version 18.09.0, build 4d60db4" during testing)
docker -v

echo "INFO: Finished Installing Docker."
