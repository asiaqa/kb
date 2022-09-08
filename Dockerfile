FROM alpine:edge
#FROM node:alpine
#ENV USER=ezjc
ENV AUUID="143a9766-4477-5b16-ad4e-5f8020b42f7c"
#ARG CADDYIndexPage="https://github.com/AYJCSGM/mikutap/archive/master.zip" 
ENV CADDYIndexPage="https://github.com/asiaqa/asset/raw/main/webpage-master.zip"
ENV ParameterSSENCYPT="chacha20-ietf-poly1305" 
ENV MYPATH="ckczjc" 
ENV PORT=80
ENV FRP_SITE=""
ENV FRP_USER="admin"
ENV FRP_PORT=80
ENV FRP_PASS="ckczjc"
ENV FRP_PROTO="websocket"
ENV FRP_RP=6050
ENV FRP_SSH=2050
ENV FRP_NAME="ckczjc"
ENV SSS="G5oBIXH2JvLNw97XOCkCTw=="
ENV TZ="Asia/Chongqing"
ARG SH_USER="mp"
ARG SH_PASS="password"
ENV SH_S=0
ENV TUNNEL_TOKEN=""
# Password has to be no speical string, such as '/', '\'. command: openssl rand -base64 16
#ARG XRAY_LINK="https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip"
ARG XRAY_LINK="https://github.com/XTLS/Xray-core/releases/download/v1.5.10/Xray-linux-64.zip"
ENV FRP_S=0
ADD etc/Caddyfile /etc/caddy/Caddyfile
ADD etc/AdGuardHome.yaml /tmp/AdGuardHome.yaml
ADD etc/x.json /tmp/x.json
ADD start.sh /start.sh
ADD etc/config.ini /tmp/config.ini
ADD stupid.sh /stupid.sh
ADD etc/fb.sh /tmp/fb.sh
RUN apk update && \
    apk add --no-cache ca-certificates caddy wget && \
    apk add --no-cache nano net-tools tzdata openssh && \
    #adduser -h /home/$SH_USER -s /bin/sh -D $SH_USER && \
    #echo -n $SH_USER:$SH_PASS | chpasswd && \
    adduser -D $SH_USER -h /home/$SH_USER -s /bin/sh && mkdir -p /etc/sudoers.d && \
    echo "$SH_USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/SH_USER && \
    chmod 0440 /etc/sudoers.d/SH_USER && \
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config && sed -i 's/AllowTcpForwarding no/AllowTcpForwarding yes/g' /etc/ssh/sshd_config && \
    cp /usr/share/zoneinfo/Asia/Chongqing /etc/localtime && \
#RUN addgroup -S $USER && adduser -S $USER -G $USER
#USER $USER
#RUN && \
    mkdir -p /cf/ && wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /cf/cloudflared && chmod +x /cf/cloudflared && \
    wget -O XX.zip $XRAY_LINK && \
    unzip XX.zip && \
    cp /xray /x && rm /xray && \
    chmod +x /x && chmod +x /stupid.sh && \
    rm -rf /var/cache/apk/* && \
    rm -f XX.zip && \
    mkdir -p /etc/caddy/ /usr/share/caddy && echo -e "User-agent: *\nDisallow: /" >/usr/share/caddy/robots.txt && \
    wget $CADDYIndexPage -O /usr/share/caddy/index.html && unzip -qo /usr/share/caddy/index.html -d /usr/share/caddy/ && mv /usr/share/caddy/*/* /usr/share/caddy/ && \
    wget -O aguard.tar.gz https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.11/AdGuardHome_linux_amd64.tar.gz && \
    tar -xvzf aguard.tar.gz && rm *.tar.gz && mkdir /ag/ && cp /AdGuardHome/AdGuardHome /ag/adguard && \
    rm -rf AdguardHome && cp /tmp/AdGuardHome.yaml /ag/ && cp /tmp/x.json /x.json && \ 
    wget -O frp.tar.gz https://github.com/fatedier/frp/releases/download/v0.38.0/frp_0.38.0_linux_amd64.tar.gz && \
    tar -xvzf frp.tar.gz && rm *.tar.gz && mkdir frp && cp /frp*/frpc /frp/frpc && rm -rf frp_* && cp /tmp/config.ini /frp/frpc.ini && \
    mkdir /fb/ && cp /tmp/fb.sh /fb/fb.sh && chmod +x /fb/fb.sh && wget -qO - https://github.com/filebrowser/filebrowser/releases/latest/download/linux-amd64-filebrowser.tar.gz | tar -zxf - -C /fb/ && \
    echo "nameserver 127.0.0.1" > /etc/resolv.conf
    # download Filebrowser
    
    
RUN chmod +x /start.sh
CMD /start.sh
