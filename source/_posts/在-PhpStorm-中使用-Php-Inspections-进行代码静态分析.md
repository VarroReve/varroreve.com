---
title: 在 PhpStorm 中使用 Php Inspections 进行代码静态分析
date: 2019-12-28 10:17:11
thumbnail: https://s2.ax1x.com/2019/12/28/leciQ0.png
tags:
- PhpStorm
- 静态分析
- Laravel
- Php Inspections
- 提高代码质量
category: Code Review
---

> [Php Inspections](https://github.com/kalessil/phpinspectionsea) 是一款 PhpStorm 的开源插件，用作静态分析

<!--more-->

根据官方介绍，它可以检测或覆盖到：

- 结构相关问题
- 弱类型控制和可能的代码结构简化
- 性能问题
- 非最佳、重复、可疑的 `if` 条件判断
- 正则表达式
- 兼容性问题
- 各类长耗时操作
- PhpUnit API 单元测试
- 安全问题
- 等等...

![](https://s2.ax1x.com/2019/12/28/lenung.png)


## 安装

在 PHPStorm 的 `Setting -> Plugins -> Marketplace` 中搜索并安装 `Php Inspections`，然后重启 IDE。

![](https://s2.ax1x.com/2019/12/28/leKkSP.gif)

## 使用

> 在安装好并重启 IDE 后，Php Inspections 的气泡提示功能就已自动启用

### 气泡提示及快速修复

![](https://s2.ax1x.com/2019/12/28/leDtBQ.gif)

当 Php Inspections 检测到代码问题时，会用灰色波浪线提示用户。将鼠标悬浮在波浪线上时，会弹出气泡并提供快速修复代码的功能，只需点击左键就可修复

图中代码一共有三处问题：

1. 在使用 ‘==’ 等号运算符判断时，其返回结果已经是 `bool` 值了，不需要用三元运算符再处理一次，可以简化
2. 该函数的返回值类型是确定的，所以可以安全地声明其返回值类型为 `bool`
3. Php Inspections 建议使用 `===` 代替 `==`，这个视业务场景决定是否使用全等号，所以 Php Inspections 也没有提供自动修复的选项

### 对整个项目进行分析

在 Laravel 项目中代码主要存在于 `app` 目录下，所以在选择分析范围时递归包含 `app` 目录就行，或者也可以分析整个项目，但一定要将 `node_modules` `vendor` 目录递归排除，不然分析过程会很耗时，也会多出些不必要的分析结果

![](https://s2.ax1x.com/2019/12/28/leKAQf.gif)

执行后在右下角会显示分析进度，等待几分钟会弹出分析报告

![](https://s2.ax1x.com/2019/12/28/leDYng.png)

可以在报告中选择某一个问题直接修复：

![](https://s2.ax1x.com/2019/12/28/leyIg0.gif)

<center>(简化 if 结构)</center>

也可以选择某一类问题全部修复：

![](https://s2.ax1x.com/2019/12/28/leyf4s.gif)

<center>(移除方法中未使用的参数，简化代码)</center>

## 其他

Php Inspections 的静态分析可以发现项目中存在的许多问题，在编写代码时也可以通过波浪线和气泡提升代码质量

此外也可以使用 Composer 拓展包 [nunomaduro/**larastan**](https://github.com/nunomaduro) 作代码静态分析
