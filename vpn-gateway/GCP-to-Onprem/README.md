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
**Some assumptions are made for the fragmentation and maximum segment size (MSS) and maximum transmission unit (MTU).
But in this instance, even if large packets are sent, there is no traffic, 
so the CPU load on the device—regardless of physical or virtual—should not be significant.**

# Verification of the Tunnel
```
Once the configuration has been edited and applied to your edge device, the tunnels should connect to GCP.
We can verify this using show crypto ikev2 sa [detail], a sample output of which is shown here:
```
```
 IPv4 Crypto IKEv2  SA

Tunnel-id Local                 Remote                fvrf/ivrf            Status
3         192.168.128.92/4500   34.157.245.14/4500    none/none            READY
      Encr: AES-CBC, keysize: 128, PRF: SHA256, Hash: SHA256, DH Grp:16, Auth sign: PSK, Auth verify: PSK
      Life/Active Time: 28800/15728 sec
      CE id: 0, Session-id: 1
      Local spi: A9D4F5D1ECBE00A5       Remote spi: 16D801035147E9B7
      Status Description: Negotiation done
      Local id: <LOCAL-PUBLIC-IP>
      Remote id: 34.157.245.14
      Local req msg id:  271            Remote req msg id:  369
      Local next msg id: 271            Remote next msg id: 369
      Local req queued:  271            Remote req queued:  369
      Local window:      5              Remote window:      1
      DPD configured for 60 seconds, retry 5
      Fragmentation not  configured.
      Dynamic Route Update: disabled
      Extended Authentication not configured.
      NAT-T is detected inside
      Cisco Trust Security SGT is disabled
      Initiator of SA : Yes
      PEER TYPE: Other
```
**Once we can confirm that the IKEv2 security associations have been established, we can verify whether the IPsec security associations have formed as well. The command to view the output is show crypto ipsec sa [detail], and the output should look similar to the following:**
```
interface: Tunnel1
    Crypto map tag: Tunnel1-head-0, local addr 192.168.128.92

   protected vrf: (none)
   local  ident (addr/mask/prot/port): (0.0.0.0/0.0.0.0/0/0)
   remote ident (addr/mask/prot/port): (0.0.0.0/0.0.0.0/0/0)
   current_peer 34.157.245.14 port 4500
     PERMIT, flags={origin_is_acl,}
    #pkts encaps: 8203, #pkts encrypt: 8203, #pkts digest: 8203
    #pkts decaps: 7875, #pkts decrypt: 7875, #pkts verify: 7875
    #pkts compressed: 0, #pkts decompressed: 0
    #pkts not compressed: 0, #pkts compr. failed: 0
    #pkts not decompressed: 0, #pkts decompress failed: 0
    #pkts no sa (send) 0, #pkts invalid sa (rcv) 0
    #pkts encaps failed (send) 0, #pkts decaps failed (rcv) 0
    #pkts invalid prot (recv) 0, #pkts verify failed: 0
    #pkts invalid identity (recv) 0, #pkts invalid len (rcv) 0
    #pkts replay rollover (send): 0, #pkts replay rollover (rcv) 0
    ##pkts replay failed (rcv): 0
    #pkts tagged (send): 0, #pkts untagged (rcv): 0
    #pkts not tagged (send): 0, #pkts not untagged (rcv): 0
    #pkts internal err (send): 0, #pkts internal err (recv) 0

     local crypto endpt.: 192.168.128.92, remote crypto endpt.: 34.157.245.14
     plaintext mtu 1422, path mtu 1500, ip mtu 1500, ip mtu idb GigabitEthernet1
     current outbound spi: 0x8C49BBAB(2353642411)
     PFS (Y/N): Y, DH group: group16

     inbound esp sas:
      spi: 0x20C196D(34347373)
        transform: esp-256-aes esp-sha-hmac ,
        in use settings ={Tunnel UDP-Encaps, }
        conn id: 2050, flow_id: CSR:50, sibling_flags FFFFFFFF80004048, crypto map: Tunnel1-head-0, initiator : True
         sa timing: remaining key lifetime (k/sec): (4607981/1592)
        IV size: 16 bytes
        replay detection support: Y  replay window size: 1024
        Status: ACTIVE(ACTIVE)

     inbound ah sas:

     inbound pcp sas:

     outbound esp sas:
      spi: 0x8C49BBAB(2353642411)
        transform: esp-256-aes esp-sha-hmac ,
        in use settings ={Tunnel UDP-Encaps, }
        conn id: 2049, flow_id: CSR:49, sibling_flags FFFFFFFF80004048, crypto map: Tunnel1-head-0, initiator : True
         sa timing: remaining key lifetime (k/sec): (4607988/1592)
        IV size: 16 bytes
        replay detection support: Y  replay window size: 1024
        Status: ACTIVE(ACTIVE)

     outbound ah sas:

     outbound pcp sas:
```
**We also should validate the status of our BGP peering with GCP. This can be found by using the <sh ip bgp summary> command:**
```
BGP router identifier 192.168.128.92, local AS number 65001
BGP table version is 3, main routing table version 3
2 network entries using 496 bytes of memory
2 path entries using 272 bytes of memory
2/2 BGP path/bestpath attribute entries using 592 bytes of memory
1 BGP AS-PATH entries using 24 bytes of memory
0 BGP route-map cache entries using 0 bytes of memory
0 BGP filter-list cache entries using 0 bytes of memory
BGP using 1384 total bytes of memory
BGP activity 2/0 prefixes, 2/0 paths, scan interval 60 secs
2 networks peaked at 20:55:55 Oct 24 2023 UTC (20:24:56.107 ago)

Neighbor        V           AS MsgRcvd MsgSent   TblVer  InQ OutQ Up/Down  State/PfxRcd
169.254.208.17  4        65010    2867    3099        3    0    0 15:54:39        1
```
**We have an active relationship with the GCP peer and are receiving the prefix from our supernet, as seen from sh ip route bgp:**
```
      10.0.0.0/20 is subnetted, 1 subnets
B        10.138.0.0 [20/100] via 169.254.208.17, 20:30:59
```
