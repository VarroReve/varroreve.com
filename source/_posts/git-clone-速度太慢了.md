---
title: GitHub 被墙后的解决办法
date: 2019-11-25 15:43:16
tags: github速度慢 github被墙 v2ray
thumbnail: https://s2.ax1x.com/2019/11/25/Mj3lGQ.jpg
---

>  现在 GitHub 网站资源被 GFW 恶化，访问速度很慢甚至打不开，使用 `git` 工具 `pull`、`push` 也很慢。解决办法就是使用科学上网软件代理 github，当然前提是已经部署好了科学上网软件（SS、V2Ray、BROOK）等。

<!-- more -->

### 访问 github.com 站点

这个在 PAC 规则中加入 github.com 域名即可。SS 已经被严重封锁，这里以 v2ray 的 Windows 客户端 `v2rayN` 举例

打开 v2rayN 的主界面，点击 `参数设置 -> Core:路由设置`

![img](https://s2.ax1x.com/2019/11/25/MjiZkV.jpg)

输入 `domain:gitub.com`，其中 `domain` 代表所有以 `gitub.com` 结尾的域名

完成设置后访问 github.com 便会走 v2ray 代理

### 设置 SSH 代理

在执行 `git push`、`git pull` 操作时，如果是走的 git 协议，那么即便开启了 SS 或 v2ray 全局代理,也起不到加速效果，这时就需要让 git 客户端走代理

#### 方法一

编辑 `~/.ssh/config` 文件，增加以下内容：

```
Host github.com
   HostName github.com
   User git
   ProxyCommand nc -v -x 127.0.0.1:10808 %h %p # 替换为自己使用的端口号
```

在 v2rayN 中，socks5 监听的端口默认是 10808，在 SS 中为 1080，根据自己的情况填写

#### 方法二

如果有使用过 `proxifier` 的话，可以直接配置 `git` 客户端走 v2ray 代理

点击 proxifier 菜单栏中的 `Profile -> Proxy Server` 新增一条代理设置

![img](https://s2.ax1x.com/2019/11/25/MjAZkt.jpg)

Port 填写本机上监听的 socks5 端口，使用 v2rayN 的话是 10808

点击 proxifier 菜单栏中的 `Profile -> Proxfication Rules` 的配置规则

![img](https://s2.ax1x.com/2019/11/25/MjknsJ.jpg)

点击 `Browse` 选择要走代理的程序，这里需要选择到 git 安装目录下的 `./usr/bin/ssh.exe` 和 `./usr/bin/git-remote-https.exe` 

Action 选择到之前设置好的代理

点击确定，这样不管是 git 协议 还是 https 协议都可以走 v2ray 代理了



### 以下方法已失效

最近 `git clone` 的速度只有几 kb，原因是 `github.global.ssl.fastly.net` 域名被限制了。

找到这个域名对应的 IP 地址，然后在 `hosts` 文件中加上域名的映射，刷新DNS缓存便可。

### 步骤

1. 在网站 [https://www.ipaddress.com](https://www.ipaddress.com/) 分别搜索：

```
github.com

github.global.ssl.fastly.net
```

2. 将查找到的 IP 地址写入到 `hosts` 文件：

```bash
192.30.253.112 github.com
151.101.185.194 github.global.ssl.fastly.net
```

3. 保存更新 DNS：

Windows 用户在 CMD 下执行： 

```bash
$ ipconfig /flushdns
```

Linux 用户在在终端执行：

```bash
$  sudo /etc/init.d/networking restart
```
