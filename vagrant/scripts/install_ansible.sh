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
echo ""
echo "INFO: Finished Installing Ansible"
echo "####################################################################################"
echo "To activate virtual environment, run the following command:"
echo "source ~/python-env/ansible2.8.4/bin/activate"
echo "####################################################################################"
echo ""
