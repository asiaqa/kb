#!/bin/sh

#tor &
ssh-keygen -A
cat /etc/caddy/Caddyfile | sed -e "s/\$MYPATH/$MYPATH/g" -e "1c :$PORT" -e "s/\$AUUID/$AUUID/g" -e "s/\$MYUUID-HASH/$(caddy hash-password --plaintext $AUUID)/g" >/etc/caddy/Caddyfile
cp /x.json /temp.json
cp /frp/frpc.ini /frpc.ini
cat /frp/frpc.ini | sed -e "s/\$FRP_SITE/$FRP_SITE/g" -e "s/\$FRP_USER/$FRP_USER/g" -e "s/\$FRP_NAME/$FRP_NAME/g" -e "s/\$FRP_PASS/$FRP_PASS/g" -e "s/\$FRP_SSH/$FRP_SSH/g" -e "s/\$FRP_PROTO/$FRP_PROTO/g" -e "s/\$FRP_RP/$FRP_RP/g" >/frpc.ini
cp /frpc.ini /frp/frpc.ini
cat /temp.json | sed -e "s/\$SSS/$SSS/g" -e "s/\$AUUID/$AUUID/g" -e "s/\$MYPATH/$MYPATH/g" -e "s/\$ParameterSSENCYPT/$ParameterSSENCYPT/g" >/x.json 
#rm /temp.json
/x -config /x.json &
/ag/adguard -c /ag/AdGuardHome.yaml -w /ag/ -l /ag/ag.log &
if [ $FRP_S == 1 ]
then
/frp/frpc -c /frp/frpc.ini &
fi
if [ $SH_S == 1 ]
then
exec /usr/sbin/sshd -D -e "$@"&
echo mp:$MYPATH | chpasswd&
fi
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
