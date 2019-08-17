---
title: '在 Laradock 中使用 Xdebug '
date: 2019-08-17 11:04:42
tags:
- laradock
- php
category: laradock
thumbnail: https://s2.ax1x.com/2019/08/17/mn5ewn.md.jpg
---

Xdebug 很强，在 Laradock 中安装也非常简单。

<!-- more -->

首先打开 laradock 项目的 `.env` 文件，定位到下面两行：

```bash
# laradock/.env

WORKSPACE_INSTALL_XDEBUG=false

PHP_FPM_INSTALL_XDEBUG=false
```

将这两个选项设为 `true` 会分别在 `workspace` 和 `php-fpm` 容器中安装 xdebug 拓展

在 `php-fpm` 中安装 xdebug 是用来调试 Http 请求，比如调试浏览器、Postman 发起的请求，`workspace` 中安装 xdebug 可以调试 CLI 请求，比如 Artisan 命令、PHP 脚本

然后打开 `laradock/php-fpm/xdebug.ini` 文件，将前两行修改为如下：

```bash
# laradock/php-fpm/xdebug.ini

# before
xdebug.remote_host=dockerhost
xdebug.remote_connect_back=1

# after
xdebug.remote_host=docker.for.win.localhost # 如果你是 Mac 用户，修改为 docker.for.mac.localhost
xdebug.remote_connect_back=0
```

之后重新构建容器：

```bash
$ docker-compose up -d --force-recreate --build workspace php-fpm
```

> 我一般只在 `php-fpm` 安装 Xdebug，印象中在 `workspace` 安装 Xdebug 后调试时会收到很多调试请求，有点烦人

查看 xdebug 是否安装成功（该命令仅可查看 `php-fpm` 容器的 xdebug）：

```bash
$ ./php-fpm/xdebug status


xDebug status
PHP 7.2.15 (cli) (built: Feb 21 2019 23:48:47) ( NTS )
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.2.0, Copyright (c) 1998-2018 Zend Technologies
    with Zend OPcache v7.2.15, Copyright (c) 1999-2018, by Zend Technologies
    with Xdebug v2.7.2, Copyright (c) 2002-2019, by Derick Rethans
```

然后打开 PHPStorm 的设置，找到 `Lanuages & Frameworks -> PHP -> Servers`，新建一个 Server，保存：

![](https://s2.ax1x.com/2019/08/17/mn0uin.jpg)

最后点击 `Run -> Start Listing for PHP Debug Connections` 开启 xdebug 调试监听：

![](https://s2.ax1x.com/2019/08/17/mnfKJO.png)

打好断点后在浏览器发起请求，应该可以看到程序进入了断点:

![](https://s2.ax1x.com/2019/08/17/mnfcT0.png)

另外在可以使用以下命令开启/关闭 `php-fpm` 容器的 xdebug：

```bash
$ ./php-fpm/xdebug start

$ ./php-fpm/xdebug stop
```

