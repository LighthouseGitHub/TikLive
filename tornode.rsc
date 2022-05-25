/system script
add dont-require-permissions=no name=TorCheckin owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/\
    tool fetch url=https://checkin.lighthouseit.us/tik/tornode.rsc\r\
    \n/log warning \"Starting Tor Exit Node refresh\"\r\
    \n:foreach rule in=[/system logging find] do={\r\
    \n:if ([:find [/system logging get \$rule topics] \"info\" -1] > -1) do={\
    \r\
    \n/system logging disable \$rule\r\
    \n}\r\
    \n}\r\
    \nimport tornode.rsc\r\
    \n:foreach rule in=[/system logging find] do={\r\
    \n:if ([:find [/system logging get \$rule topics] \"info\" -1] > -1) do={\
    \r\
    \n/system logging enable \$rule\r\
    \n}\r\
    \n}\r\
    \n/log warning \"Tor Exit Node refresh finished\""
