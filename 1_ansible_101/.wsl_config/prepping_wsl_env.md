# Install WSL

Follow steps below or read the full Installation Guide here: https://docs.microsoft.com/en-us/windows/wsl/install-win10

## Enable "Windows Subsystem for Linux" optional feature

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```

## Install your Linux Distribution of Choice

I chose `Ubuntu 18.04` found here: https://www.microsoft.com/en-gb/p/ubuntu-1804-lts/9n9tngvndl3q

## Install Ansible and Configure Kerberos

```bash
# Update and upgrade packages
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Python and Kerberos packages
sudo apt-get install python-dev libkrb5-dev krb5-user python-pip -y
  # Default Kerberos version 5 realm:
  SUMMIT2019.LOCAL
  # Kerberos servers for your realm:
  dc01.summit2019.local
  # Administrative server for your Kerberos realm:
  dc01.summit2019.local

# Install Ansible and packages required for Windows WinRM
sudo pip install --upgrade ansible pywinrm kerberos requests-kerberos requests-credssp

# Add host entry for dc01 (needed for kerberos / AD comms used in 4_custom_module_demo)
'192.168.56.2    dc01.summit2019.local' | sudo tee -a /etc/hosts
```

## WSL Mount Permissions

### Problem

Initially, you may get the following warning when trying to run `ansible-playbook playbook.yml`:

```plain
[WARNING] Ansible is being run in a world writable directory (/mnt/c/Users/<USERNAME>/code/PSSummit2019/1_ansible_101),
ignoring it as an ansible.cfg source. For more information see:
https://docs.ansible.com/ansible/devel/reference_appendices/config.html#cfg-in-world-writable-dir

[WARNING]: No inventory was parsed, only implicit localhost is available

[WARNING]: provided hosts list is empty, only localhost is available.
Note that the implicit localhost does not match 'all'
```

However, you can now set the owner and group of files using chmod/chown and modify read/write/execute permissions in WSL:
https://devblogs.microsoft.com/commandline/chmod-chown-wsl-improvements/

### Fix

Run the commands below to create or update `/etc/wsl.conf`

```bash
echo '[automount]' | sudo tee -a /etc/wsl.conf
echo 'options = "metadata,umask=22,fmask=11"' | sudo tee -a /etc/wsl.conf
```

**Note**: after Win10 1903 you have to wait a few minutes for something magical to happen for the new mount options to appear, or forcibly terminate the wsl session with `wsl.exe --terminate Ubuntu-18.04`.

If the above terminate command doesn't work, you may need to use a different WSL distribution name. List installed distributions using: `wsl.exe --list`

### Force Remount Option

Another alternative is to forcibly remount the volume like so:

```bash
cd ~
sudo umount /mnt/c
sudo mount -t drvfs C: /mnt/c -o metadata,uid=1000,gid=1000,umask=22,fmask=11
cd -
```

Now exit and reload bash. This mount option will allow you to modify permissions so that ansible can read the `ansible.cfg` file in your project directory.  The umask setting will cause all new files and directories to have permissions compatible with ansible.

If you already have files and folders created, `cd` to ansible directory and run `chmod 755 . -R` to set the permissions to a compatible value.
