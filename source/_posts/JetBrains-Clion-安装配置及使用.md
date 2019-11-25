---
title: JetBrains Clion 安装配置及使用
date: 2019-11-15 16:50:23
tags: clion gdb
---

### 下载安装 MinGW

这里必须注意的是下载压缩包，不要下载离线安装的版本，不然会装到猴年马月，而且安装难度较大。

打开下载地址：[MinGW](https://sourceforge.net/projects/mingw-w64/files/Toolchains targetting Win64/Personal Builds/mingw-builds/) 进入下载页面，下载最新版

![img](https://upload-images.jianshu.io/upload_images/13625730-806c72ecb2fc619e.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

![img](https://upload-images.jianshu.io/upload_images/13625730-3b5125205d16dec2.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

### 配置 CLion

 打开 CLion，左上角 File-Settings-Build-Toolchains，然后点击 **+** 号


![img](https:////upload-images.jianshu.io/upload_images/13625730-59b19c35c9589ad0.png?imageMogr2/auto-orient/strip|imageView2/2/w/908/format/webp)

![img](https:////upload-images.jianshu.io/upload_images/13625730-9c1c7b4ac50f2320.png?imageMogr2/auto-orient/strip|imageView2/2/w/624/format/webp)

然后 CLion 会自动帮你填上所有你该填的东西，点击 OK ，等调试的小虫子变绿就可以了。

![img](https:////upload-images.jianshu.io/upload_images/13625730-9f5aa1e8408cef27.png?imageMogr2/auto-orient/strip|imageView2/2/w/781/format/webp)

### 下载 GDB