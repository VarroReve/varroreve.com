---
title: Linux 下的解密游戏 Over The Wire - Bandit
date: 2019-09-11 10:17:38
tags: linux
thumbnail: https://s2.ax1x.com/2019/11/25/MXzeYQ.jpg
---

### Bandit Level 6 → Level 7

> Level Goal
>
> The password for the next level is stored **somewhere on the server** and has all of the following properties:
>
> - owned by user bandit7
> - owned by group bandit6
> - 33 bytes in size

递归查找所有大小为 33b 、拥有者为 bandit6 、用户组为 bandit7 的文件

```bash
find -size 33c -user bandit7 -group bandit6

# HKBPTKQnIay4Fw76bEy8PVxKEDQRKTzs
```

### Bandit Level 7 → Level 8

> Level Goal
>
> The password for the next level is stored in the file **data.txt** next to the word **millionth**

```bash
cat data.txt |grep millionth

# cvX2JJa4CFALtqS87jk27qwqGhBM9plV
```

### Bandit Level 8 → Level 9

> Level Goal
>
> The password for the next level is stored in the file **data.txt** and is the only line of text that occurs only once

查找 data.txt 文件中只出现了一次的行

sort: 按字母序排序

uniq: 报告或省略重复的行

```bash
cat data.txt | sort | uniq -c

# UsvVyFSfZZWbi6wgC7dAFyFuR6jQQUhR
```

### Bandit Level 9 → Level 10

>Level Goal
>
>The password for the next level is stored in the file **data.txt** in one of the few human-readable strings, beginning with several ‘=’ characters.

strings: 打印文件中可打印的字符串

```bash
 cat data.txt | strings | grep =
 
 # truKLdjsbJ5g7yyJ2X2R0o3a5HQJFuLk
```

### Bandit Level 9 → Level 10

> Level Goal
>
> The password for the next level is stored in the file **data.txt**, which contains base64 encoded data

```bash
 cat data.txt | base64 -d

# IFukwKGsFW8MOq3IRFqrxE1hxTNEbUPR
```

### Bandit Level 11 → Level 12

> Level Goal
>
> The password for the next level is stored in the file **data.txt**, where all lowercase (a-z) and uppercase (A-Z) letters have been rotated by 13 positions

`rotated by 13 positions` 是一种简单的加密方式，将一个英文字母用它后十三位的字母替换

```bash
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'

# 5Te8Y4drgCRfCx8ugdwuEX8KFC6k2EUu
```

### Bandit Level 12 → Level 13

> Level Goal
>
> The password for the next level is stored in the file **data.txt**, which is a hexdump of a file that has been repeatedly compressed. For this level it may be useful to create a directory under /tmp in which you can work using mkdir. For example: mkdir /tmp/myname123. Then copy the datafile using cp, and rename it using mv (read the manpages!)

这一关的 data.txt 是一个被反复压缩过的十六进制文件，需要先使用 `xxd` 反向 dump，再用 `file` 命令查看文件是被什么工具压缩的，最后一层一层把它解压出来。

```
# 8ZjyCRiBWFYkneahHwxCv3wb2a1ORpYL
```



ssh -i ./sshkey.private bandit14@localhost
