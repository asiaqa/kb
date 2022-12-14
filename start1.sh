#!/bin/sh

#tor &
sed -i "s/\$DNS/$DNS/g" /ag/AdGuardHome.yaml
/ag/adguard -c /ag/AdGuardHome.yaml -w /ag/ -l /ag/ag.log&
if [[ $TUNNEL_TOKEN ]]
then
  /cf/cloudflared tunnel --no-autoupdate run --token $TUNNEL_TOKEN --protocol auto&
fi
ssh-keygen -A
cp /etc/caddy/Caddyfile /file
rm -rf /etc/caddy/*
temp=$(caddy hash-password --plaintext $FRP_PASS)
cat /file | sed -e "s#\$FRP_PASS-HASH#$temp#g" -e "s/\$FRP_NAME/$FRP_NAME/g" -e "s/\$MYPATH/$MYPATH/g" -e "1c :$PORT" -e "s/\$AUUID/$AUUID/g" >/etc/caddy/Caddyfile
cp /x.json /temp.json
cp /frp/frpc.ini /frpc.ini
cat /frp/frpc.ini | sed -e "s/\$FRP_SITE/$FRP_SITE/g" -e "s/\$FRP_USER/$FRP_USER/g" -e "s/\$FRP_NAME/$FRP_NAME/g" -e "s/\$FRP_PASS/$FRP_PASS/g" -e "s/\$FRP_SSH/$FRP_SSH/g" -e "s/\$FRP_PROTO/$FRP_PROTO/g" -e "s/\$FRP_RP/$FRP_RP/g" >/frpc.ini
cp /frpc.ini /frp/frpc.ini
cat /temp.json | sed -e "s/\$SSS/$SSS/g" -e "s/\$DNS/$DNS/g" -e "s/\$AUUID/$AUUID/g" -e "s/\$MYPATH/$MYPATH/g" -e "s/\$ParameterSSENCYPT/$ParameterSSENCYPT/g" >/x.json 
#rm /temp.json
/x -config /x.json &
/fb/fb.sh&
if [ $FRP_S == 1 ]
then
  /frp/frpc -c /frp/frpc.ini &
fi
if [ $SH_S == 1 ]
then
  exec /usr/sbin/sshd -D -e "$@"&
  echo mp:$MYPATH | chpasswd&
  echo root:$MYPATH | chpasswd&
fi
if [ $DNS == 53 ]
then 
  echo "nameserver 127.0.0.1" > /etc/resolv.conf
fi
pkill caddy
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile&
#/usr/sbin/crond -f -l 8&
#/usr/bin/crontab 21 8 * * * /download.sh
echo '21 8,20 * * * /download.sh >> /script.log' >> /etc/crontabs/root&
crond -f -l 8
