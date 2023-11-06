/interface bridge
add name=bridge-local
/interface list
add name=WAN
add name=LAN
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip dhcp-server option
add code=66 name=VOIP value="'http://ndp.ucaasnetwork.com/cfg/'"
/ip ipsec profile
add dh-group=modp4096 dpd-interval=10s enc-algorithm=aes-256 hash-algorithm=sha384 name="Main STS"
/ip ipsec proposal
add auth-algorithms=sha256 enc-algorithms=aes-256-cbc name="Main STS" pfs-group=modp4096
/system logging action
set 1 disk-file-count=30
add disk-file-count=20 disk-file-name=ErrorLog name=Error target=disk
add disk-file-count=10 disk-file-name=CriticalLog name=Critical target=disk
add disk-file-count=10 disk-file-name=IPsecLog name=IPsec target=disk
add disk-file-count=10 disk-file-name=WarningLog name=Warning target=disk
add disk-file-count=10 disk-file-name=Infolog name=Info target=disk
/interface bridge port
add bridge=bridge-local interface=ether2
add bridge=bridge-local interface=ether3
add bridge=bridge-local interface=ether4
add bridge=bridge-local interface=ether5
add bridge=bridge-local interface=ether6
add bridge=bridge-local interface=ether7
add bridge=bridge-local interface=ether8
add bridge=bridge-local interface=ether9
add bridge=bridge-local interface=ether10
add bridge=bridge-local interface=ether11
add bridge=bridge-local interface=ether12
add bridge=bridge-local interface=ether13
add bridge=bridge-local interface=sfp-sfpplus1
add bridge=bridge-local interface=sfp-sfpplus2
add bridge=bridge-local interface=sfp-sfpplus3
add bridge=bridge-local interface=sfp-sfpplus4
/ip neighbor discovery-settings
set discover-interface-list=!dynamic
/interface list member
add interface=bridge-local list=LAN
/ip address
add address=192.168.20.8/24 interface=ether12 network=192.168.20.0
/ip dhcp-client
add disabled=yes interface=ether12
/ip dns
set servers=1.1.1.1,8.8.8.8
/ip route
add disabled=no dst-address=0.0.0.0/0 gateway=192.168.20.4 routing-table=main suppress-hw-offload=no
/system clock
set time-zone-name=America/Chicago
/system identity
set name=CHANGEME
/system logging
set 0 action=Info
set 1 action=Error topics=error,!ipsec
set 2 action=Warning
set 3 action=Critical
add action=IPsec topics=error,ipsec
