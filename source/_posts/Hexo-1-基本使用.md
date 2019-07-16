---
title: Hexo - 1. 基本使用
date: 2019-07-13 10:47:44
tags:
- Hexo 
category:
- Hexo
thumbnail: https://s2.ax1x.com/2019/07/16/Zb2CSx.jpg
---

> [Hexo](https://hexo.io/zh-cn/) 是一个轻量级的博客框架，使用起来也非常简单，但是 Hexo 在多台机器工作、部署到个人网站等场景下有些麻烦。
<!-- more -->

## 前言

网上有很多 Hexo 的使用教程，不过大部分不太全面，一些特别需求也没有现成的解决方案。我的需求主要有:

- 可在多台工作机器同时写博客
- 写完博客后自动更新代码仓库
- 发布到 Github Pages
- 打包并自动部署到我自己的服务器
- 自动抓取我的简历页面、生成 PDF、上传到七牛云存储

这些工作我需要在编辑完一篇文章、使用 `git push` 后自动完成。现在总结下整个过程。

## 环境准备

需要 node 和 git，如果需要 Travis 自动部署代码到自己的服务器，还需要 ruby 环境。

```bash
$ git version
$ node -v
$ npm -v
```

## 安装 Hexo

使用 NPM 全局安装 Hexo：

```bash
$ npm install hexo-cli -g
```

查看 Hexo 版本信息：

```bash
$ hexo -v

hexo: 3.9.0
hexo-cli: 2.0.0
os: Windows_NT 10.0.17763 win32 x64
node: 11.12.0
v8: 7.0.276.38-node.18
uv: 1.26.0
zlib: 1.2.11
brotli: 1.0.7
ares: 1.15.0
modules: 67
nghttp2: 1.34.0
napi: 4
llhttp: 1.1.1
http_parser: 2.8.0
openssl: 1.1.1b
cldr: 34.0
icu: 63.1
tz: 2018e
unicode: 11.0

```

初始化博客：

```bash
$ hexo init blog
$ cd blog
$ npm install

```

启动 hexo 服务：

```bash
$ hexo s # 或者 hexo serve 
```


此时访问 [http://localhost:4000](http://localhost:4000) 应该可以看到 hexo 的初始界面：
![](https://s2.ax1x.com/2019/07/16/Zb6hjS.jpg)

### 基本使用

新建一篇 Markdown 文章：

```bash
$ hexo new "My New Post"
```

在 `/source/_posts` 下找到这篇新文章，然后编辑。

生成静态文件：

```bash
$ hexo g # 或者 hexo generate 
```



