/system script
add dont-require-permissions=no name=RegionBlockList owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/\
    log warning \"Starting China Region List refresh\"\r\
    \n/tool fetch url=https://checkin.lighthouseit.us/tik/lists/cn_list.rsc\r\
    \n:foreach rule in=[/system logging find] do={\r\
    \n:if ([:find [/system logging get \$rule topics] \"info\" -1] > -1) do={\
    \r\
    \n/system logging disable \$rule\r\
    \n}\r\
    \n}\r\
    \nimport cn_list.rsc\r\
    \n:foreach rule in=[/system logging find] do={\r\
    \n:if ([:find [/system logging get \$rule topics] \"info\" -1] > -1) do={\
    \r\
    \n/system logging enable \$rule\r\
    \n}\r\
    \n}\r\
    \n/log warning \"Finished China Region List refresh\"\r\
    \n:delay 10\r\
    \n/log warning \"Starting Russia Region List refresh\"\r\
    \n/tool fetch url=https://checkin.lighthouseit.us/tik/lists/ru_list.rsc\r\
    \n:foreach rule in=[/system logging find] do={\r\
    \n:if ([:find [/system logging get \$rule topics] \"info\" -1] > -1) do={\
    \r\
    \n/system logging disable \$rule\r\
    \n}\r\
    \n}\r\
    \nimport ru_list.rsc\r\
    \n:foreach rule in=[/system logging find] do={\r\
    \n:if ([:find [/system logging get \$rule topics] \"info\" -1] > -1) do={\
    \r\
    \n/system logging enable \$rule\r\
    \n}\r\
    \n}\r\
    \n/log warning \"Finished Russia Region List refresh\""
