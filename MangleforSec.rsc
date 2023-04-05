:local Seccon [/interface get [find name ~"Failover"] name]
:local gw [/ip route get [find comment="secondary gateway"] value-name=gateway]
/routing table
add fib name="SecWinboxTable"
/ip firewall mangle
add action=mark-connection chain=prerouting comment="Allow Winbox $Seccon" dst-port=8291 in-interface=$Seccon new-connection-mark="2nd winbox" passthrough=no protocol=tcp
add action=mark-connection chain=prerouting in-interface=$Seccon new-connection-mark="2nd winbox" passthrough=no protocol=icmp
add action=mark-routing chain=prerouting dst-port=8291 in-interface=$Seccon new-routing-mark="SecWinboxTable" passthrough=no protocol=tcp
add action=mark-routing chain=prerouting in-interface=$Seccon new-routing-mark=SecWinboxTable passthrough=no protocol=icmp
add action=mark-routing chain=prerouting connection-mark="2nd winbox" log=yes new-routing-mark="SecWinboxTable" passthrough=no
add action=mark-routing chain=output connection-mark="2nd winbox" new-routing-mark="SecWinboxTable" passthrough=no    
/ip route
add check-gateway=ping comment="Route for 2nd connection monitoring" distance=2 gateway=$gw routing-table="SecWinboxTable"
