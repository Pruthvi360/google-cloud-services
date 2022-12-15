Installing Ansible

Operating system ubuntu-22.10

sudo apt-get install python-pip python-dev-is-python3

sudo pip install 'ansible==2.0.0.1' 

OR

And if you want to have more than one installed version, just use create virtualenv:

virtualenv .env
source .env/bin/activate
pip install 'ansible==2.2.0.0'

OR

$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
$ sudo apt update
$ sudo apt install ansible

Verify installation

$ ansible --version

Make config Directory

mkdir ansible
vi ansible.cfg

ansible-galaxy collection install google.cloud
