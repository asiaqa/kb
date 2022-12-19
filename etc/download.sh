#!/bin/sh
export geosite_path=$1
wget -O /geosite.dat $geosite_path
wget -O /geoip.dat $geoip_path
now=$(date)
echo "Downloaded date and time: $now" >> /download.log
