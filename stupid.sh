#!/bin/sh
#cat /temp.json | sed -e "s/\$SSS/$SSS/g" -e "s/\$AUUID/$AUUID/g" -e "s/\$MYPATH/$MYPATH/g" -e "s/\$ParameterSSENCYPT/$ParameterSSENCYPT/g" >/xray.json 
#rm /temp.json
cp /frp/frpc.ini cp /frpc.ini
cat /frpc.ini | sed -e "s/\$FRP_SITE/$FRP_SITE/g" -e "s/\$FRP_USER/$FRP_USER/g" -e "s/\$FRP_PASS/$FRP_PASS/g" -e "s/\$FRP_PROTO/$FRP_PROTO/g" -e "s/\$FRP_RP/$FRP_RP/g" >/frp/frpc.ini 
#/frp/frpc -c /frp/frpc.ini &
