#!/bin/bash

# Vault options
# Encrypt full vars file
ansible-vault encrypt group_vars/all.yml --ask-vault-pass
# Decrypt full vars file
ansible-vault decrypt group_vars/all.yml --ask-vault-pass

# Encrypt a single var named 'ansible_password', with value 'vagrant'
ansible-vault encrypt_string --ask-vault-pass 'vagrant' --name 'ansible_password'

# Standard command no longer works
ansible-playbook playbook.yml

# '--ask-vault-pass' switch must be used to prompt for vault password
# '--step' is used to prompt user at every step
ansible-playbook playbook.yml --ask-vault-pass --step
