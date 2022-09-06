#!/bin/sh

# Configure filebrowser
if [ ! -f "/fb/data/config/filebrowser.db" ]; then
    filebrowser -d /fb/data/config/filebrowser.db config init
    filebrowser -d /fb/data/config/filebrowser.db users add $FRP_NAME $FRP_PASS --perm.admin --commands="sv,du,df,free,nslookup,netstat,top,ps"
    if [ "${GLOBAL_LANGUAGE}" = "chs" ]; then
        filebrowser -d /fb/data/config/filebrowser.db users update $FRP_NAME --locale zh-cn
    fi
else
    if [ "${GLOBAL_LANGUAGE}" = "chs" ]; then
        filebrowser -d /fb/data/config/filebrowser.db users add $FRP_NAME $FRP_PASS --perm.admin --locale zh-cn --commands="sv,du,df,free,nslookup,netstat,top,ps"
    else
        filebrowser -d /fb/data/config/filebrowser.db users add $FRP_NAME $FRP_PASS --perm.admin --commands="sv,du,df,free,nslookup,netstat,top,ps"
    fi
    filebrowser -d /fb/data/config/filebrowser.db users update $FRP_NAME -p $FRP_PASS
fi

filebrowser -d /fb/data/config/filebrowser.db config set -r / -b $MYPATH/files -p 61801

# Run filebrowser
exec 2>&1
exec filebrowser -d /fb/data/config/filebrowser.db
