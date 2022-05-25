/system script
add dont-require-permissions=no name=Checkin owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/lo\
    g info \"Lighthouse Mikrotik checkn\"\r\
    \n/log info \"checking for Gateway\"\r\
    \n:if ( [/ip route find dst-address=\"0.0.0.0/0\"] = \"\" ) do={\r\
    \n /log info \"Waiting 20 seconds for default gateway\"\r\
    \n /log info \"Trying Ether1 and DHCP client\"\r\
    \n /ip dhcp-client add interface=ether1 disabled=no\r\
    \n {:delay 20};\r\
    \n}\r\
    \n:if ( [/ip route find dst-address=\"0.0.0.0/0\"] = \"\" ) do={\r\
    \n /log info \"Still no default gateway.  Waiting 60 Seconds\"\r\
    \n {:delay 60};\r\
    \n}\r\
    \n:if ([:len [/file find name=checkin.rsc]] > 0) do={\r\
    \n/file remove checkin.rsc\r\
    \n}\r\
    \n/log info \"Gateway Found\"\r\
    \n/log info \"Checking Routerboard Model\"\r\
    \ndelay 2\r\
    \n:global rModel [/system resource get board-name]\r\
    \n:if (\$rModel = \"RB2011UiAS-2HnD r2\") do={:set rModel RB2011}\r\
    \n:if (\$rModel = \"RB2011UiAS-2HnD\") do={:set rModel RB2011}\r\
    \n:if (\$rModel = \"hEX\") do={:set rModel hex}\r\
    \n:if (\$rModel = \"RB3011UiAS\") do={:set rModel RB3011}\r\
    \n:if (\$rModel = \"RB1100AHx4\") do={:set rModel RB1100}\r\
    \n:if (\$rModel = \"RB4011iGS+\") do={:set rModel RB4011}\r\
    \n:if (\$rModel = \"RB4011iGS+5HacQ2HnD\") do={:set rModel RB4011}\r\
    \n/log info \"Model = \$rModel\"\r\
    \ndelay 1\r\
    \n/log info \"LH checkin Downloading checkin.rsc\"\r\
    \n/tool fetch url=\"https://checkin.lighthouseit.us/\$rModel/checkin.rsc\" m\
    ode=https dst-path=\"checkin.rsc\"\r\
    \ndelay 5\r\
    \n/log info \"LH checkin Download Finished\"\r\
    \n/log info \"LH checkin Running import of LH_checkin\"\r\
    \n/import checkin.rsc\r\
    \ndelay 15\r\
    \n/log info \"LH checkin Running import of LH_checkin finished\"\r\
    \ndelay 5\r\
    \n/log info \"Running Cleanup\"\r\
    \nfile remove checkin.rsc\r\
    \ndelay 2\r\
    \n/log info \"LH checkin V8 Finished\""
    
