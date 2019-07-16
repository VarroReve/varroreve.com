---
title: 使用 Laravel IDE helper + Laravel plugin 提升开发效率
date: 2019-07-12 18:56:23
tags:
- phpstorm
- laravel
category: phpstorm
thumbnail: https://s2.ax1x.com/2019/07/12/ZfUEsH.jpg
---
> 使用 Laravel 时，我们常常会用到拓展包 [Laravel IDE helper](https://github.com/barryvdh/laravel-ide-helper) 来帮助本地开发。而 [Laravel plugin](https://github.com/Haehnchen/idea-php-laravel-plugin) 是一款 PHPStorm 的插件，将这两者配合使用，可以较大的提升开发效率。
<!-- more -->

## Laravel IDE helper
> 这个扩展包能让 IDE (PHPStorm, Sublime) 实现自动补全、代码智能提示和代码跟踪等功能，在 [Laravel 扩展排行榜](https://learnku.com/laravel/projects/filter/laravel-library) 上长期居于前五。

### 安装
```bash
composer require barryvdh/laravel-ide-helper --dev
```

### 使用
```bash
php artisan ide-helper:generate - 为 Facades 生成 phpDocs 注释
php artisan ide-helper:models - 为 Models 生成 phpDocs 注释
php artisan ide-helper:meta - 为 PhpStorm 生成类路径提示文件
```

## Laravel plugin
> 在 PHPStorm 使用 Laravel 框架开发时，常常会使用 config()、view()、trans() 等辅助函数。然后就有个很尴尬的事情发生了：

> 当我想知道 config('app.locale') 被定义在代码中何处或者想修改它的值时，我就需要搜索或者顺着文件目录找到它；当我想打开 view('welcome') 这个视图文件时，我需要搜索或者在目录中找到它；想知道 trans('order.create.success') 对应的不同翻译更麻烦。

> 而 Laravel plugin 非常好的解决了这个问题。

### 功能演示
当 Laravel plugin 被启用后，就可以使用它提供的功能：

`config()` 代码补全
![Laravel](https://cdn.learnku.com/uploads/images/201906/01/26289/Op8uN37TcF.png!large)

使用 Ctrl + 鼠标左键点击 `config()` 后跳转到该配置项所在的文件
![Laravel](https://cdn.learnku.com/uploads/images/201906/01/26289/yPKbEsVA1d.png!large)

在路由文件中使用 Ctrl + 鼠标左键点击后跳转到控制器中对应的方法
![Laravel](https://cdn.learnku.com/uploads/images/201906/01/26289/7sKGVvnvER.png!large)

该功能对 `view()`、`trans()`、`Redirect::action()`、`View::make()`、`Config::get()`、`Lang::get()` 等函数都有同样的作用。
![[插件推荐] 使用 PHPStorm 中的 Laravel Plugin 插件提升开发效率](https://cdn.learnku.com/uploads/images/201906/01/26289/J7pjlDKRlC.png!large)

使用 [动态模板](https://github.com/koomai/phpstorm-laravel-live-templates) 生成代码片段（使用 Ctrl + J 以弹出代码补全提示框）
![[插件推荐] 使用 PHPStorm 中的 Laravel Plugin 插件提升开发效率](https://cdn.learnku.com/uploads/images/201906/01/26289/7eEpnKJ88g.png!large)

Blade 语法支持（使用该功能时，在输入完 [@] 后需要按 Ctrl + 空格才可以弹出代码补全提示框）
![[插件推荐] 使用 PHPStorm 中的 Laravel Plugin 插件提升开发效率](https://cdn.learnku.com/uploads/images/201906/01/26289/T1VzxjBIzy.png!large)
![[插件推荐] 使用 PHPStorm 中的 Laravel Plugin 插件提升开发效率](https://cdn.learnku.com/uploads/images/201906/01/26289/7F2Ai68XPn.png!large)
![[插件推荐] 使用 PHPStorm 中的 Laravel Plugin 插件提升开发效率](https://cdn.learnku.com/uploads/images/201906/01/26289/hduwIya5ZS.png!large)

以及其他的一些功能

### 安装方法
在 PHPStorm 中打开 `Settings -> Plugins -> Marketplace`，找到 `Laravel` 插件并安装：

![[插件推荐] 使用 PHPStorm 中的 Laravel Plugin 插件提升开发效率](https://cdn.learnku.com/uploads/images/201905/31/26289/uKWzGhF5Ne.png!large)

安装后启用该插件：

![[插件推荐] 使用 PHPStorm 中的 Laravel Plugin 插件提升开发效率](https://cdn.learnku.com/uploads/images/201905/31/26289/WoXbKW96B0.png!large)

之后还需要对当前的项目使用该插件（注意每一个项目都需要单独启用该设置）：

![[插件推荐] 使用 PHPStorm 中的 Laravel Plugin 插件提升开发效率](https://cdn.learnku.com/uploads/images/201905/31/26289/8JGZ9nyZFp.png!large)

最后需要重启编辑器。

## 引用
-  [Laravel plugin 官方文档地址](https://www.jetbrains.com/help/phpstorm/laravel.html)
-  [Laravel IDE helper](https://github.com/barryvdh/laravel-ide-helper/blob/master/readme.md)