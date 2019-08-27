---
title: 解决 laravel 项目中使用 npm 监听代码改动导致 IDE 卡死的问题
date: 2019-08-27 11:04:20
tags:
- phpstorm
category: phpstorm
thumbnail: https://s2.ax1x.com/2019/08/27/m4siWD.md.png
---

> 在 laravel 项目中，涉及前端代码的地方可能经常需要使用 `npm run watch-poll` 监听代码改动并重新编译资源。如果用的 IDE 是 PHPStorm 或者 WebStorm，每次改完代码自动编译时，IDE 都会重新建立索引，这会占用很多的系统资源，并且在建立索引期间 IDE 的一些功能会无法使用。

解决方法：

1. 将 `node_modules` 目录标记为 `Excluded`（高版本的 PHPStorm、WebStorm 已经把它自动标记 `Excluded` 了）。

   ![](https://s2.ax1x.com/2019/08/27/m4Bffg.jpg)

2. 将 `public` 或 `public/js` 目录标记为 `Excluded`。

   ![](https://s2.ax1x.com/2019/08/27/m4B4pQ.jpg)

之后运行 `npm dev`、`npm run watch-poll` 时就不会无限建立索引了。