Thanks for the org contributor of this program, I did remove the Tor service, customize the path and hide the docker path. I still don't know how to connect it via Trojan, SS and Socks....   

And Add the ENV defintion when depoly..

# Xray-Docker on cloud docker service starting from "K"

通过ws传输的(vmess、vless、trojan、shadowsocks、socks)等协议

# 请勿使用常用的账号部署此项目，以免封号！！

## 部署步骤

1. fork本仓库
2. 在`Dockerfile`内第3-6行修改自定义设置，说明如下：

`AUUID`：用来部署节点的UUID，如有需要可在[uuidgenerator](https://www.uuidgenerator.net/)生成, Default: 143a9766-4477-5b16-ad4e-5f8020b42f7c

`CADDYIndexPage`：伪装站首页文件

`ParameterSSENCYPT`：ShadowSocks加密协议

`MYPATH`：Path for SS/VLESS/VMESS Default: ckczjc

3. 去[Docker Hub](https://hub.docker.com/)注册一个账号，如有账号可跳过
4. 添加Actions的Secrets变量，变量说明如下

`DOCKER_USERNAME`：Docker Hub ID

`DOCKER_PASSWORD`：Docker Hub 登录密码

`DOCKER_PATH`：Docker Hub 按照“name: Docker Hub ID/自定义镜像名称”格式修改


6. 打开某容器云主页，新建一个应用
7. 应用配置如下所示

`Docker Image`：Docker Hub镜像地址，格式为“docker.io/Docker Hub ID/自定义镜像名称”

`Container size`：部署配置，一般默认即可

`Port`：80

Environment variables：

`Key`：PORT，`Value`：80

`Key`：MYPATH，`Value`："any path that you want"

`Key`：AUUID，`Value`：UUID that you are using

`Name`：自己定义

8. 客户端配置如下所示

V2ray

```
地址：xxx.prod-glb.koyeb.app
端口：443
默认UUID：24b4b1e1-7a89-45f6-858c-242cf53b5bdb
vmess额外id：0
加密：none
传输协议：ws
伪装类型：none
伪装域名：xxx.prod-glb.koyeb.app
路径：/path/XXX
vless使用(/path/vm)，vmess使用(/path/vmess)
底层传输安全：tls
跳过证书验证：false
```

Trojan-go

```bash
{
    "run_type": "client",
    "local_addr": "127.0.0.1",
    "local_port": 1080,
    "remote_addr": "xxx.prod-glb.koyeb.app",
    "remote_port": 443,
    "password": [
        "24b4b1e1-7a89-45f6-858c-242cf53b5bdb"
    ],
    "websocket": {
        "enabled": true,
        "path": "/path/trojan",
        "host": "xxx.prod-glb.koyeb.app"
    }
}
```

ShadowSocks

```bash
服务器地址: xxx.koyeb.app
端口: 443
密码：24b4b1e1-7a89-45f6-858c-242cf53b5bdb
加密：chacha20-ietf-poly1305
插件程序：xray-plugin_windows_amd64.exe
说明：需将插件 https://github.com/shadowsocks/xray-plugin/releases 下载解压后放至shadowsocks同目录
插件选项: tls;host=xxx.prod-glb.koyeb.app;path=/path/ss
```

## 注意

请勿滥用本仓库

## 赞助我们

![afdian-MisakaNo.jpg](https://s2.loli.net/2021/12/25/SimocqwhVg89NQJ.jpg)
