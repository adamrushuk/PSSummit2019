#!/bin/bash

# Install Ansible
echo "INFO: Started Installing Ansible..."

# Configure virtual environment for Python 3 / Ansible 2.8.4
python36 --version
mkdir -p ~/python-env
cd ~/python-env
python36 -m venv ansible2.8.4
source ~/python-env/ansible2.8.4/bin/activate
pip -V

# Install Ansible and pywinrm (for Windows support)
pip install --upgrade pip setuptools ansible[azure]==2.8.4 pywinrm
echo "INFO: Finished Installing Ansible."
echo "INFO: To activate virtual environment, run 'source ~/python-env/ansible2.8.4/bin/activate'"
