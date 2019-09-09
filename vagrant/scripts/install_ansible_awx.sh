#!/bin/bash

# Vars
ansible_git_folder="/home/vagrant/python-env/ansible2.8.4/awx/"
virtual_env_folder="/home/vagrant/python-env/ansible2.8.4/"
awx_repo_url="https://github.com/ansible/awx.git"
inventory_source_path="/vagrant/vagrant/scripts/inventory"
installer_folder="$ansible_git_folder/installer"

# Installs Ansible AWX
echo "INFO: Started Installing Ansible AWX..."

# Activate virtual env
cd "$virtual_env_folder"
source bin/activate

# Install prereq: Docker SDK for Python
echo "INFO: Started Installing Docker SDK for Python..."
pip install docker
echo "INFO: Finished Installing Docker SDK for Python."

# Clone repo
if [ ! -d "$ansible_git_folder" ]
then
    echo "INFO: Cloning Ansible AWX repo..."
    git clone "$awx_repo_url"
else
    echo "INFO: Ansible AWX repo already exists...SKIPPING."
fi

# Copy (overwrite) inventory file from vagrant share
echo "INFO: Copying Ansible AWX Inventory file..."
\cp "$inventory_source_path" "$installer_folder/inventory"

# Run installer Playbook
echo "INFO: Running Ansible AWX install playbook..."
cd "$installer_folder"
ansible-playbook -i inventory install.yml

echo "INFO: Finished Installing Ansible AWX."
echo "INFO: Confirm build by running 'docker ps' and 'docker logs -f awx_task'"
