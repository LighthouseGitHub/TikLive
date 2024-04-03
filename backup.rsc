/system script
add dont-require-permissions=no name=SFTP_BACKUP owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":global naboo\r\
    \n:global tatooine\r\
    \n:global rName\r\
    \n:global naboo\r\
    \n/log info \"Lighthouse Mikrotik backup\"\r\
    \n/log info \"checking for Gateway\"\r\
    \n:if ( [/ip route find dst-address=\"0.0.0.0/0\"] = \"\" ) do={\r\
    \n /log info \"Waiting 20 seconds for default gateway\"\r\
    \n /log info \"Trying Ether1 and DHCP client\"\r\
    \n /ip dhcp-client add interface=ether1-gateway disabled=no\r\
    \n {:delay 20};\r\
    \n}\r\
    \n:if ( [/ip route find dst-address=\"0.0.0.0/0\"] = \"\" ) do={\r\
    \n /log info \"Still no default gateway.  Waiting 60 Seconds\"\r\
    \n {:delay 60};\r\
    \n}\r\
    \n/log info \"Gateway Found\"\r\
    \n/log info \"Building Backup\"\r\
    \ndelay 2\r\
    \n/export file=export.rsc;\r\
    \n/log info \"Backup Created\"\r\
    \ndelay 1\r\
    \n:global rName [/system identity get name] \r\
    \n/log info \"Posting to REP Server\"\r\
    \n/log info \$naboo\r\
    \n/tool fetch address=\$naboo mode=sftp user=\"TIKup\" password=\$tatooine src-path=\"export.rsc\" dst-path=\"\$rName\\\\\$rName.rsc\" upload=yes\r\
    \n/log info \"Posted to REP Server\"\r\
    \ndelay 5\r\
    \n/log info \"Starting Cleanup\"\r\
    \ndelay 15\r\
    \nfile remove export.rsc\r\
    \n/log info \"Backup Cleaned up\"\r\
    \ndelay 1\r\
    \n/log info \"LH sftp Backup Complete\""
