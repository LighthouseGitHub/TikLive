:local Seccon [/interface get [find name ~"Failover"] name]
:local gw [/ip route get [find comment="secondary gateway"] value-name=gateway]
/routing table
add fib name="SecWinboxTable"
/ip firewall mangle
add action=mark-connection chain=prerouting comment="Allow Winbox through COAX connection" dst-port=8291 in-interface=$Seccon new-connection-mark="2nddary winbox" passthrough=yes protocol=tcp
add action=mark-connection chain=prerouting comment="Allow ping through COAX connection" in-interface=$Seccon new-connection-mark="2nddary winbox" passthrough=yes protocol=icmp
add action=mark-routing chain=output connection-mark="2nddary winbox" new-routing-mark=SecWinboxTable
/ip route
add comment="Route for 2nd connection monitoring" distance=2 gateway=$gw routing-table="SecWinboxTable"
