---
title: oh-my-zsh 安装及插件使用
date: 2019-11-23 09:26:14
tags: ohmyzsh
---

> Your terminal nerver felt **this** good before. 

### 安装 zsh

使用 `apt` 或 `yum` 安装 zsh

```bash
$ apt install zsh
```

切换 shell 为 zsh

```bash
$ chsh -s /bin/zsh

Changing shell for root.
Shell changed.
```

退出终端再重新进入，可以看到 shell 已切换到 zsh

### 安装 oh my zsh

执行一键安装脚本

```bash
$ wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
```

退出终端再重新进入,可以看到 oh my zsh 已生效

### 插件安装

zsh-autosuggestions 可以提示历史输入过的命令，使用以下命令安装

```bash
$ git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

编辑 zsh 配置文件

```bash
$ vim ~/.zshrc

# 在插件中加上 zsh-autosuggestions
plugins=(
  git
  extract
  z
  zsh-autosuggestions
)
```

刷新配置文件

```bash
$ source ~/.zshrc
```

### 主题设置

在 [主题列表](https://github.com/robbyrussell/oh-my-zsh/wiki/themes) 中选择合适的主题，然后修改配置文件

```bash
$ vim ~/.zshrc

# 修改主题名称
ZSH_THEME="cloud"
```

刷新配置文件

```bash
$ source ~/.zshrc
```

### 其他

输入 `cd` 有时候会卡，是因为 `oh my zsh ` 在获取目录下的 `git` 信息，可以设置隐藏 git 信息

```bash
git config --global oh-my-zsh.hide-status 1
```

