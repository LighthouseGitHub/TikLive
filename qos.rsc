/queue tree
add comment=Download max-limit=200M name=Inbound parent=bridge-local
add comment=Upload max-limit=10M name=Outbound parent=ether1-gateway
add max-limit=9M name=Data-Out packet-mark=non-voip,no-mark parent=Outbound
add max-limit=125k name=ICMP-Out packet-mark=icmp parent=Outbound
add max-limit=5M name=VoIP-Out packet-mark=voip-out parent=Outbound
/queue type
set 0 kind=sfq
set 1 kind=sfq
set 9 kind=sfq
/queue tree
add max-limit=5M name=VoIP-IN packet-mark=voip-in parent=Inbound priority=2 queue=default
add max-limit=190M name=Data-In packet-mark=non-voip,no-mark parent=Inbound queue=default
add max-limit=125k name=ICMP-IN packet-mark=icmp parent=Inbound priority=3 queue=default
/ip firewall mangle
add action=mark-packet chain=prerouting comment="Data Rules" new-packet-mark=\
    non-voip passthrough=yes src-address-list=!voip
add action=mark-packet chain=prerouting comment="VoIP Rules" new-packet-mark=\
    voip-in passthrough=yes protocol=udp src-address-list=voip
add action=change-dscp chain=prerouting new-dscp=46 passthrough=yes protocol=\
    udp src-address-list=voip
add action=mark-packet chain=postrouting dst-address-list=voip new-packet-mark=\
    voip-out passthrough=yes protocol=udp
add action=change-dscp chain=postrouting dst-address-list=voip new-dscp=46 \
    passthrough=yes protocol=udp
add action=mark-packet chain=prerouting comment=ICMP new-packet-mark=icmp \
    passthrough=yes protocol=icmp
