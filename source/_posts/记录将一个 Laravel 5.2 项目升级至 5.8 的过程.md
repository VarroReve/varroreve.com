---
title: '记录将一个 Laravel 5.2 项目升级至 5.8 的过程'
date: 2019-09-04 15:53:24
tags:
---

公司有一个比较老的项目，使用 Laravel 5.2，两年内未曾升过级。现在因为版本太低无法满足需求，需要升级至

5.8。

这个项目有多达 900 条路由，前后七八个人维护过，大家的代码风格、写法、技巧各不相同，并且还对框架改造过，加上从 5.2 升级至 5.8 跨度很大，所以这次升级有很大的风险。

为使项目平稳升级，我的做法是先升级至 5.3，然后测试、上线、修复 BUG，然后升级至 5.4，测试、上线、修复 BUG……直至升级到 5.8。而每一次升级分为以下几个步骤，这几个步骤也是本文要重点介绍的内容：

- 升级框架内核及依赖
- 升级框架本体
- 代码静态分析
- 测试
- Sentry 监控报错日志

## 升级框架内核及依赖

升级框架内核，也就是要升级 `vendor/laravel` 目录下的框架源码，这一步根据 [升级说明](https://learnku.com/docs/laravel/5.8/upgrade/3877)，将 `composer.json` 中相关的依赖升级、并更新可能会受影响的代码。这一步比较容易。

## 升级框架本体

升级框架内核，也就是要升级项目下框架自带的文件。比如说在 Laravel 5.5 中，日志相关的配置项是写在 `config/app.php` 文件中，而在 Laravel 5.6 中这些配置项被移动到了一个单独的配置文件 `config/loggin.php` 中。

这些变化在 [升级说明](https://learnku.com/docs/laravel/5.8/upgrade/3877) 中有的不会被提及，这就需要我们自己对比 Laravel 不同版本间框架本体的区别。

以项目从 5.5 升级至 5.6 为例，我是这样来对比的：

首先将项目切换到一个新的本地分支：

```bash
git checkout -b uprade_to_5.6
```

为项目设置 Laravel 官方源：

```bash
git remote add laravel https://github.com/laravel/laravel
```

然后拉取 5.6 版本的官方代码：

```bash
git fetch laravel 5.6
```

下面我将借助 PHPStorm 强大的版本控制工具来完成代码对比。

首先点击 PHPStorm 右下角的 `Git:uprade_to_5.6` 按钮，点击 `laravel/5.6 -> Show Diff With Working Tree`

![](https://s2.ax1x.com/2019/09/04/nZ9p90.png)

![](https://s2.ax1x.com/2019/09/04/nZpxNn.png)

得到如下的 diff 结果：

![](https://s2.ax1x.com/2019/09/04/nZ993V.png)

这个结果表示了我的本地分支 uprade_to_5.6 与 laravel/5.6 中哪些文件发生了变化。

可以看到这个结果中不同的文件名有不同的颜色，其中：

- 「绿色」表示 laravel/5.6 拥有的而 uprade_to_5.6 没有的文件
- 「蓝色」表示该文件在 uprade_to_5.6 与 laravel/5.6 中有差异
- 「灰色」表示 uprade_to_5.6 拥有而 laravel/5.6 没有的文件

在这个例子中，就相当于是：laravel/5.6 比 stagin 多了 `CHANGELOG.md, .editorconfig` 等文件，少了 `.gitlab-ci.yml, _ide_helper.php` 等文件，而 `.env.example, .gitigonre` 等文件与 uprade_to_5.6 的有差异。

对于「绿色（新增）」的文件，可以在文件上 `右键 -> Get From Branch` ，将这个新增的文件从 laravel/5.6 复制到 uprade_to_5.6 分支上。比如说 laravel/5.6 新增了 `config/logging.php` 文件，现在可以将这个文件复制到本地分支上：

![](https://s2.ax1x.com/2019/09/04/nZpzhq.png)

!(https://s2.ax1x.com/2019/09/04/nZ9CcT.png)

对于「蓝色（有差异）」的文件，可以选中文件，然后 `右键 -> Show Diff` 或 `Ctrl + D` 来对比文件差异、合并代码。现在来对比 `config/app.php` 文件：

![](https://s2.ax1x.com/2019/09/04/nZCGsU.png)

对比界面分为了左右两部分，左边为 uprade_to_5.6 的 `config/app.php` 文件，右边为 laravel/5.6 的，可以看到在 laravel/5.6 中删除了日志相关的配置（因为将这些配置项移动到 `config/logging.php` 中了），新增了 `Illuminate\Auth\Passwords\PasswordResetServiceProvider::class` ，这时我点击 `<<` 按钮，选择接受来自 laravel/5.6 分支的更新。当然你也可以在 Diff 面板的左侧自己编写合并后的代码。

对于「灰色（被删除）」的文件，这些一般是我们自己添加的文件，在 laravel/5.6 分支上当然是没有的，基本不用管。

将项目中每一个有差异的文件审阅，最终我的项目的框架主体便与 laravel 官方应用保持了同步。

## 代码静态分析



### Php Inspections

### larastan