/interface bridge
add name=bridge-local
/interface ethernet
set [ find default-name=ether1 ] name=ether1-gateway
set [ find default-name=ether10 ] name=ether10-Failover
/interface list
add name=WAN
add name=LAN
/ip dhcp-server option
add code=66 name=VOIP value="'http://ndp.ucaasnetwork.com/cfg/'"
/interface bridge port
add bridge=bridge-local ingress-filtering=no interface=ether2
add bridge=bridge-local ingress-filtering=no interface=ether3
add bridge=bridge-local ingress-filtering=no interface=ether4
add bridge=bridge-local ingress-filtering=no interface=ether5
add bridge=bridge-local ingress-filtering=no interface=ether6
add bridge=bridge-local ingress-filtering=no interface=ether7
add bridge=bridge-local ingress-filtering=no interface=ether8
add bridge=bridge-local ingress-filtering=no interface=ether9
add bridge=bridge-local ingress-filtering=no interface=sfp-sfpplus1
add bridge=bridge-local ingress-filtering=no interface=wlan1
add bridge=bridge-local ingress-filtering=no interface=wlan2
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa2-psk eap-methods="" mode=dynamic-keys name=profile1 supplicant-identity="" wpa2-pre-shared-key="CHANGEME"
/interface wireless
set [ find default-name=wlan1 ] band=5ghz-n/ac channel-width=20/40mhz-Ce country="united states3" disabled=no frequency=auto mode=ap-bridge security-profile=profile1 ssid=CHANGEME
set [ find default-name=wlan2 ] band=2ghz-g/n channel-width=20/40mhz-eC country="united states3" disabled=no frequency=auto mode=ap-bridge security-profile=profile1 ssid=CHANGEME
/interface list member
add interface=ether1-gateway list=WAN
add interface=bridge-local list=LAN
/ip dns
set servers=1.1.1.1,8.8.8.8
/tool graphing interface
add interface=ether1-gateway
/system logging action
set 1 disk-file-count=30
add disk-file-count=20 disk-file-name=ErrorLog name=Error target=disk
add disk-file-count=10 disk-file-name=CriticalLog name=Critical target=disk
add disk-file-count=10 disk-file-name=IPsecLog name=IPsec target=disk
add disk-file-count=10 disk-file-name=WarningLog name=Warning target=disk
add disk-file-count=10 disk-file-name=Infolog name=Info target=disk
/system clock
set time-zone-name=America/Chicago
/system logging
set 0 action=Info
set 1 action=Error topics=error,!ipsec
set 2 action=Warning
set 3 action=Critical
add action=IPsec topics=error,ipsec
/ip ipsec profile
add dh-group=modp4096 dpd-interval=10s enc-algorithm=aes-256 hash-algorithm=sha384 name="Main STS"
/ip ipsec proposal
add auth-algorithms=sha256 enc-algorithms=aes-256-cbc name="Main STS" pfs-group=modp4096
