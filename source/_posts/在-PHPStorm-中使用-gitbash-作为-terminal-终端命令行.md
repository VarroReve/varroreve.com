---
title: 在 PhpStorm 中使用 gitbash 作为 terminal 终端命令行
date: 2019-07-25 09:47:19
tags: PhpStorm
---

> 平时一直使用 `git bash` 命令行，每次使用时要先到项目中，右键 `Git bash here`，或者先右键再进入目录，用起来有点麻烦。
> PhpStorm 自带了终端界面，按 `ALT + F12` 调出。Windows 下 PhpStorm 默认使用的终端是 `cmd.exe`，和 `git bash` 的风格很不同，用起来很不习惯。
> 现在把 PHPStorm 的终端从 `cmd` 设置为 `git bash` 就可以解决这两个问题。

<!-- more -->

打开 PHPStorm 的设置，定位到 `Tools -> Terminal`:

![](https://s2.ax1x.com/2019/07/25/eZ8ukV.png)

将 `Shell Path` 选项改为 `{git 安装目录}\bin\sh.exe`，重新打开终端，可以看到已切换成了 `git bash`。

![](https://s2.ax1x.com/2019/07/25/eZJ7F0.png)

另外 `git bash` 可能会出现中文乱码的问题，需要在 Git 的安装目录下找到 `./etc/bash.bashrc` 文件，在末尾添加：

```bash
$ vim ./etc/bash.bashrc

# support chinese
export LANG="zh_CN.UTF-8"
export LC_ALL="zh_CN.UTF-8"
```

