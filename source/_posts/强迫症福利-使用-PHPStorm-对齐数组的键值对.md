---
title: '[强迫症福利] 使用 PHPStorm 对齐数组的键值对'
date: 2019-07-11 10:13:18
tags:
- phpstorm
category: phpstorm
thumbnail: https://s2.ax1x.com/2019/07/14/Z5o5y8.md.jpg
---
在 PHPStorm 中定义数组时往往会写成下面这样：
```php
    public function index()
    {
        return [
            'foo' => 'bar',
            'foo-bar' => 'foo-bar',
            'f' => 'b'
        ];
    }
```
这时就有一群强迫症跳出来说这个组数的键值怎么没对齐、怎么没有尾随逗号、太丑了不能看。。这时更改 PHPStorm 中的一些设置项，便可达到下面的效果：
```php
    public function index()
    {
        return [
            'foo'     => 'bar',
            'foo-bar' => 'foo-bar',
            'f'       => 'b',
        ];
    }
```
***设置步骤***

打开 `Settings -> Editor -> PHP -> Warpping and Braces`，找到 `Array itializer -> Align key-value paipars` 并勾选、保存，那么在使用 `Ctrl + Alt + L` 格式化代码时便会自动对齐数组的键值对：

![[PHPStorm] 格式化代码时对其数组](https://iocaffcdn.phphub.org/uploads/images/201905/31/26289/L6OS4IACA1.jpg!large)

此外建议在 `Code Conversion` 中勾选这两项：

![[PHPStorm] 格式化代码时对其数组](https://iocaffcdn.phphub.org/uploads/images/201905/31/26289/E7VJ9UVze1.png!large)

在格式化时这两项分别会强制使用数组短语法、最后一个元素自动尾随一个逗号。

PS：注意低版本的 PHPStorm 中 以上配置项的位置可能会不同，可在搜索框中直接输入配置项的名称来定位。
