#sudo apt update

#sudo apt upgrade

#hostnamectl  > to view underlying OS

#egrep -c '(vmx|svm)' /proc/cpuinfo   > to check KWM is support in your machine.

#sudo apt install qemu-kvm libvirt-daemon-system virtinst libvirt-clients bridge-utils  > installing essential KVM dependencies

#sudo systemctl enable libvirtd   > enable libvirt

#sudo systemctl start libvirtd    > to start libvirtd

#sudo systemctl status libvirtd   > to check libvirtd status

#sudo usermod -aG kvm $USER       > add user to KVM group

#sudo usermod -aG libvirt $USER   > add user to libvirt group

#sudo nano /etc/netplan/01-netcfg.yaml > edit yaml file

#network:
    ethernets:
       eth0:
          dhcp4: false
          dhcp6: false
     bridges:
        br0:
           interfaces: [eth0]
           dhcp4: false
           addresses: [10.254.152.27/24]
           macaddress: 01:26:3b:4b:1d:43
           routes:
              - to: default
                via: 10.254.152.1
                metric: 100
           nameservers:
                addresses: [8.8.8.8]
           parameters:
               stp: false
          dhcp6: false
     version: 2
     
     
  #sudo netplan apply
     
  #ip addr show
