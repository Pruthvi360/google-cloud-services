#! /bin/bash/
sudo apt update
sudo apt upgrade -y
cd /home/admin_/
sudo apt install git -y
git clone https://github.com/Pruthvi360/dynamic-invenory
cd dynamic-invenory
chmod +x start.sh
./start.sh
