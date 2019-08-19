---
title: git clone 速度太慢了!
date: 2019-08-19 15:43:16
tags:
---

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

Winodws 用户在 CMD 下执行： 

```bash
$ ipconfig /flushdns
```

Linux 用户在在终端执行：

```bash
$  sudo /etc/init.d/networking restart
```
