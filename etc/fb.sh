#!/bin/sh

# Configure filebrowser
if [ ! -f "/fb/data/config/filebrowser.db" ]; then
    /fb/filebrowser -d /fb/data/config/filebrowser.db config init
    /fb/filebrowser -d /fb/data/config/filebrowser.db users add $FRP_NAME $FRP_PASS --perm.admin --commands="cd,cp,rm,crontab,sv,du,df,free,nslookup,netstat,top,ps,ifconfig,dig,ping,ssh,chmod,cd,ls"
    if [ "${GLOBAL_LANGUAGE}" = "chs" ]; then
        /fb/filebrowser -d /fb/data/config/filebrowser.db users update $FRP_NAME --locale zh-cn
    fi
else
    if [ "${GLOBAL_LANGUAGE}" = "chs" ]; then
        /fb/filebrowser -d /fb/data/config/filebrowser.db users add $FRP_NAME $FRP_PASS --perm.admin --locale zh-cn --commands="cd,cp,rm,crontab,sv,du,df,free,nslookup,netstat,top,ps,ifconfig,dig,ping,ssh,chmod,cd,ls"
    else
        /fb/filebrowser -d /fb/data/config/filebrowser.db users add $FRP_NAME $FRP_PASS --perm.admin --commands="cd,cp,rm,crontab,sv,du,df,free,nslookup,netstat,top,ps,ifconfig,dig,ping,ssh,chmod,cd,ls"
    fi
    /fb/filebrowser -d /fb/data/config/filebrowser.db users update $FRP_NAME -p $FRP_PASS
fi

/fb/filebrowser -d /fb/data/config/filebrowser.db config set -r /usr/share/ -b /my/$MYPATH/files -p 61801

# Run filebrowser
exec 2>&1
exec /fb/filebrowser -d /fb/data/config/filebrowser.db
