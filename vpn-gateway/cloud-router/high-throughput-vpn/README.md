## Run this command in cloud shell

### This all command belong to CLOUD VPC

## Create VPC named "cloud"

gcloud compute networks create cloud --subnet-mode custom

## Firewall rules enable SSH and icmp 

gcloud compute firewall-rules create cloud-fw --network cloud --allow tcp:22,tcp:5001,udp:5001,icmp

## Create subnets in us-east1 region.

gcloud compute networks subnets create cloud-east --network cloud \
    --range 10.0.1.0/24 --region us-east1

## This all below command below to On-Prem VPC

gcloud compute networks create on-prem --subnet-mode custom

## Firewall rules enable SSH and icmp 

gcloud compute firewall-rules create on-prem-fw --network on-prem --allow tcp:22,tcp:5001,udp:5001,icmp

## Create subnets in us-central1 region.

gcloud compute networks subnets create on-prem-central \
    --network on-prem --range 192.168.1.0/24 --region us-central1
    
## Create VPN GATEWAY ON ON-PREM VPC

gcloud compute target-vpn-gateways create on-prem-gw1 --network on-prem --region us-central1

## Create VPN GATEWAY ON CLOUD VPC

gcloud compute target-vpn-gateways create cloud-gw1 --network cloud --region us-east1

## Creating a route-based VPN tunnel between local and Google Cloud networks SIMULATION

## CREATE STATIC EXTERNAL IP FOR THE VPN GATEWAY

gcloud compute addresses create on-prem-gw1 --region us-central1

gcloud compute addresses create cloud-gw1 --region us-east1

## First, for the cloud-gw1 gateway:

cloud_gw1_ip=$(gcloud compute addresses describe cloud-gw1 \
    --region us-east1 --format='value(address)')
    
## Second, for the on-prem-gw1 gateway:

on_prem_gw_ip=$(gcloud compute addresses describe on-prem-gw1 \
    --region us-central1 --format='value(address)')
    
## Forward the Encapsulating Security Payload (ESP) protocol from cloud-gw1

gcloud compute forwarding-rules create cloud-1-fr-esp --ip-protocol ESP \
    --address $cloud_gw1_ip --target-vpn-gateway cloud-gw1 --region us-east1
    
## Forward UDP:500 traffic from cloud-gw1:

gcloud compute forwarding-rules create cloud-1-fr-udp500 --ip-protocol UDP \
    --ports 500 --address $cloud_gw1_ip --target-vpn-gateway cloud-gw1 --region us-east1
    
## Forward UDP:4500 traffic from cloud-gw1:

gcloud compute forwarding-rules create cloud-fr-1-udp4500 --ip-protocol UDP \
    --ports 4500 --address $cloud_gw1_ip --target-vpn-gateway cloud-gw1 --region us-east1
    
## Forward the ESP protocol from on-prem-gw1

gcloud compute forwarding-rules create on-prem-fr-esp --ip-protocol ESP \
    --address $on_prem_gw_ip --target-vpn-gateway on-prem-gw1 --region us-central1
    
## Forward UDP:500 traffic, used in establishing the IPsec tunnel from on-prem-gw1:

gcloud compute forwarding-rules create on-prem-fr-udp500 --ip-protocol UDP --ports 500 \
    --address $on_prem_gw_ip --target-vpn-gateway on-prem-gw1 --region us-central1
    
## Forward UDP:4500 traffic, which carries the encrypted traffic from on-prem-gw1:

gcloud compute forwarding-rules create on-prem-fr-udp4500 --ip-protocol UDP --ports 4500 \
    --address $on_prem_gw_ip --target-vpn-gateway on-prem-gw1 --region us-central1
    
## Create the VPN tunnel from on-prem to cloud

gcloud compute vpn-tunnels create on-prem-tunnel1 --peer-address $cloud_gw1_ip \
    --target-vpn-gateway on-prem-gw1 --ike-version 2 --local-traffic-selector 0.0.0.0/0 \
    --remote-traffic-selector 0.0.0.0/0 --shared-secret=[MY_SECRET] --region us-central1
    
## Create the VPN tunnel from cloud to on-prem:

gcloud compute vpn-tunnels create cloud-tunnel1 --peer-address $on_prem_gw_ip \
    --target-vpn-gateway cloud-gw1 --ike-version 2 --local-traffic-selector 0.0.0.0/0 \
    --remote-traffic-selector 0.0.0.0/0 --shared-secret=[MY_SECRET] --region us-east1
    
## Route traffic from the on-prem VPC to the cloud 10.0.1.0/24 range into the tunnel:

gcloud compute routes create on-prem-route1 --destination-range 10.0.1.0/24 \
    --network on-prem --next-hop-vpn-tunnel on-prem-tunnel1 \
    --next-hop-vpn-tunnel-region us-central1

## Route traffic from the cloud VPC to the on-prem 192.168.1.0/24 range into the tunnel:

gcloud compute routes create cloud-route1 --destination-range 192.168.1.0/24 \
    --network cloud --next-hop-vpn-tunnel cloud-tunnel1 --next-hop-vpn-tunnel-region us-east1
    
## Testing throughput over VPN To test throughput use iperf, an open-source tool for network load testing.

## CREATE AN INSTANCE IN CLOUD VPC

gcloud compute instances create "cloud-loadtest" --zone "us-east1-b" \
    --machine-type "n1-standard-4" --subnet "cloud-east" \
    --image-family "debian-11" --image-project "debian-cloud" --boot-disk-size "10" \
    --boot-disk-type "pd-standard" --boot-disk-device-name "cloud-loadtest"
    
## Create a virtual machine for the on-prem VPC 

gcloud compute instances create "on-prem-loadtest" --zone "us-central1-a" \
    --machine-type "n1-standard-4" --subnet "on-prem-central" \
    --image-family "debian-11" --image-project "debian-cloud" --boot-disk-size "10" \
    --boot-disk-type "pd-standard" --boot-disk-device-name "on-prem-loadtest"
    
## ssh into the cloud-loadtest VM.

gcloud compute ssh cloud-loadtest --zone us-east1-b

sudo apt-get install iperf

iperf -s -i 5

## ssh into the on-prem-loadtest VM.

gcloud compute ssh on-prem-loadtest --zone us-central1-a

sudo apt-get install iperf

## below command creates iperf server on the VM that reports its status every 5 seconds.

iperf -s -i 5

## ssh into the cloud-loadtest VM.

gcloud compute ssh cloud-loadtest --zone us-east1-b

iperf -c 192.168.1.2 -P 20 -x C


Trouble shooting for the issues you may face
Note: This is not part of lab instructions.
While creating tunnels for the local network, if you forgot to replace [MY_SECRET] with "sharedsecret".
You can delete the created VPN tunnels by following command:

gcloud compute vpn-tunnels delete [tunnel-name] --region [region]
Copied!
replace [tunnel-name] with name of the tunnel

replace [region] with the region which you specified while creating tunnel.

If you are having trouble with the section single VPN load testing:
Make sure you installed iperf on both VMs.

In case of connection refused error, verify that:

Firewall rules for created networks (tcp:5001)
The server is running properly on on-prem-loadtest
You are trying to connect to the server via cloud-loadtest
If you are trying to see the forwarding rules that you created in the Console:
In the Navigation menu go to the Networking section.

Click on Hybrid Connectivity > VPN.

Click on the Cloud VPN Gateway to view the Cloud VPN Gateway details page.

