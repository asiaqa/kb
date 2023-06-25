#!/bin/sh
killall x
rm -rf /etc/caddy/vless* /etc/caddy/trojan* /etc/caddy/vmess*
wget -O /geosite.dat $1 && \
wget -O /geoip.dat $geoip_path && \
now=$(date) && \
echo "Downloaded date and time: $now" >> /download.log && \
/x -config /x.json >> /proc/1/fd/1 & 
