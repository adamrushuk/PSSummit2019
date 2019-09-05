#!/bin/bash

# Install common utils
echo "INFO: Started Installing Extra Packages Repo and useful utils..."
sudo yum update -y
sudo yum install -y epel-release --enablerepo=extras
sudo yum install -y gcc libffi-devel python-devel openssl-devel tree git vim bash-completion
# Python 3
sudo yum install -y python36 python36-pip
echo "INFO: Finished Installing Extra Packages Repo and useful utils."
