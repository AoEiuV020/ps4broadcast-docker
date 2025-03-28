# ~~归档，不用了~~
~~官方ps remote play现在可以隐藏顶部提示了， 画面清晰流畅方面比直播这套好的多，~~

# 取消归档，还是有用的
新版mac上obs直接捕获ps remote play应用的话会同时捕获声音并影响soundSource工作，  
而obs另一种旧版窗口捕获的话又很暗，  
直播捕获的虽然清晰度差点，但是明暗是最好的，可能mac或者ps remote play对hdr没处理好，  

# ps4broadcast-docker
ps4broadcast打包docker镜像，用于openwrt+uu+obs直播ps5，  
支持架构： linux/amd64,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/s390x  

[![Docker Pulls](https://img.shields.io/docker/pulls/aoeiuv020/ps4broadcast)](https://hub.docker.com/r/aoeiuv020/ps4broadcast)

## 使用
```shell
docker run --rm -p 26666:26666 -p 1935:1935 -p 6667:6667 -it --init --name ps4b aoeiuv020/ps4broadcast
```
启动起来就可以了，配合obs使用什么都不要配置，并且该镜像调整过入口会自动启动代理服务不需要登录26666点击，这个端口也可以省略，  
如果有其他需求请移步[原项目](https://github.com/Tilerphy/ps4broadcast)，  

### 转发流到OBS
启动docker, 假设ip为 192.168.2.45  
[注册twitch](https://www.twitch.tv/settings/profile)，
[获取推送码](https://dashboard.twitch.tv/u/aoeiuv020/settings/stream)，即主题直播秘钥，假设为 live_ddddddddd_xxxxxxxxxxxxxxxxxxxxxxx  
ps5上登录绑定自己twitch账号，  
obs中添加“vlc视频源”，设置里的“播放列表”添加一条地址指向该docker，  
```
rtmp://192.168.2.45/app/live_ddddddddd_xxxxxxxxxxxxxxxxxxxxxxx
```
把ps5访问目标1935和6667端口请求全部转发到192.168.2.45，  
这一步如果ps5的网关是openwrt就看[下一节](#openwrt网关)，直接使用iptables即可，否则自己想办法，  

最后在ps5上进入游戏后开启twitch直播，obs这边的“vlc视频源”就会播放游戏画面，  
每次关闭游戏都会导致直播关闭，再进入游戏时要重新开启，  
obs这边如果“vlc视频源”画面卡住了或者没有显示，可以点右边的小眼睛图标，隐藏再显示就会刷新，  

### openwrt网关
重点是与uu加速器共存，  
uu开关加速会动态修改防火墙规则并在PREROUTING链拦截主机的所有转发，  
因此我们的rtmp拦截规则必须在uu规则创建之后自动置顶，  
[firewall.user](./firewall.user)  
将该脚本上传到openwrt中，修改开头的ip为实际运行docker的真实ip，  
然后整个脚本追加到/etc/firewall.user，  
重启防火墙后脚本会一直监控防火墙PREROUTING，  
发现rtmp两条规则不是置顶状态就会删除并重新插入到顶部，  
有点粗暴，所以请确保路由器上没有其他类似的粗暴的脚本在运行，  
```shell
cat firewall.user >> /etc/firewall.user
```

### 延迟高画面糊
正常，这直播就这水平，vlc看直播延迟就是这么大，  
整体表现是不如窗口录制官方[PS Remote Play](https://remoteplay.dl.playstation.net/remoteplay/lang/cs/index.html)的，  
唯一的优势就是，直播时游戏画面**没有顶部的正在远程提示**，
