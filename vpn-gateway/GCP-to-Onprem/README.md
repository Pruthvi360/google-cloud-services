# This configuration template requires the following variables to be populated:
```
<GCP-PUBLIC-IP>: Public IP address of the GCP VPN gateway

<PSK>: Pre-shared key

<LOCAL-PUBLIC-IP>: Your public IP address

<LOCAL-VTI-IP>: IP address of your local endpoint over the GCP tunnel (address given above for the "Peer BGP IP address")

<REMOTE-VTI-IP>: IP address of the GCP endpoint for the tunnel (address given above for the "Cloud Router BGP IP address")

<UPSTREAM-INTERFACE>: Interface of your router facing the internet

<LOCAL-AS>: BGP ASN of your local router

<REMOTE-AS>: BGP ASN of the GCP cloud router

<LOCAL-NETWORK>: Subnet of the local network behind the on-premises router that you wish to advertise via BGP

<LOCAL-NETWORK-MASK>: Mask of the local network behind the on-premises router that you wish to advertise via BGP
```
# Some assumptions are made for the fragmentation and maximum segment size (MSS) and maximum transmission unit (MTU).
# But in this instance, even if large packets are sent, there is no traffic, 
# so the CPU load on the device—regardless of physical or virtual—should not be significant.
