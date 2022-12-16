Installing Ansible

Operating system ubuntu-22.10

sudo apt update

sudo apt install python3-pip -y

python3 -m pip -V

pip install requests google-auth

sudo apt install ansible -y

ansible-config init --disabled -t all > ansible.cfg

ansible-galaxy collection install google.cloud

ansible-galaxy collection list

Verify installation

$ ansible --version

Create service account in gcp give compute admin permission
Download json file
Upload it to your ansible controller and specify path in gcp.yaml file.

Make config Directory

vi ansible.cfg

[defaults]
inventory      = /home/admin_/gcp.yaml

[inventory]
enable inventory plugins, default: 'host_list', 'script', 'auto', 'yaml', 'ini', 'toml'
enable_plugins = host_list, virtualbox, yaml, constructed, google.cloud.gcp_compute, gcp_compute

vi gcp.yaml

---
plugin: gcp_compute

projects:
  - youtube-demo-371815

auth_kind: serviceaccount
service_account_file: /home/admin_/service_account.json

keyed_groups:
  - key: labels
    prefix: label
  - key: zone
    prefix: zone
groups:
  remote: "'ansible-local-host' in (labels|list)"
  
  
ansible-inventory -i /home/admin_/gcp.yaml --list
ansible-inventory -i /home/admin_/gcp.yaml --graph
