---
title: 列出目录下所有被 git 忽略的文件
date: 2019-10-10 18:23:48
tags:
---

以下命令中 `find . -type f` 将以递归方式列出文件夹中的所有文件，同时 `git check-ignore` 列出列表中的被忽略的文件

```bash
find . -type f  | git check-ignore --stdin
```

如果要再排除掉某些不必要目录，比如 `vendor`，可以用加上 `! -path ` 参数

```bash
nd . -type f ! -path "./vendor/*" | git check-ignore --stdin
```