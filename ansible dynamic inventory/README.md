Installing Ansible

Operating system Debian-11

$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
$ sudo apt update
$ sudo apt install ansible

Verify installation

$ ansible --version

Make config Directory

mkdir ansible
vi ansible.cfg

ansible-galaxy collection install google.cloud
