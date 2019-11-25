---
title: MySQL 慢日志分析
date: 2019-11-25 09:39:01
tags: MySQL MySQL慢日志
thumbnail: https://s2.ax1x.com/2019/11/25/Mj3QPg.jpg
---

### 安装 MySQLsla

```bash
# 下载 mysqlsla
$ wget http://hackmysql.com/scripts/mysqlsla-2.03.tar.gz 

# 解压并进入目录
$ tar zxvf mysqlsla-2.03.tar.gz && cd  mysqlsla-2.03

# 配置
$ perl Makefile.PL

# 安装
$ make && make install
```

如果在执行 `perl Makefile.PL` 时可能会报错

报错一：

```bash
Can't locate ExtUtils/MakeMaker.pm

# 解决方法
$ yum install perl-ExtUtils-MakeMaker
```

报错二：

```bash
Can't locate Time/HiRes.pm in @INC

# 解决方法
$ yum install perl-Time-HiRes
```

报错三：

```bash
Can't locate DBI.pm in @INC (you may need to install the DBI module)

# 解决方法
$ yum install perl-DBI
```

### 分析 MySQL 慢日志

日志文件可能会有很多个，为了方便分析，将这些文件聚合为一个日志文件

```bash
$ cd mysql-logs
$ ls
mysql-slowquery.log.15  mysql-slowquery.log.18  mysql-slowquery.log.22
mysql-slowquery.log.00  mysql-slowquery.log.16  mysql-slowquery.log.20  mysql-slowquery.log.23
mysql-slowquery.log.1   mysql-slowquery.log.17  mysql-slowquery.log.21

# 聚合日志文件, 并输出到 mysql-slowquery.log 文件
$ find ./ -name "mysql-slowquery.log.*" | xargs cat > mysql-slowquery.log
```

使用以下命令分析日志文件

```bash
# --log-type 选项表示要分析的日志类型为慢日志, --top 200 表示按 SQL 查询次数排序取前 200 名, 最后将分析结果写入 combine.log 文件
$ mysqlsla --log-type slow --top 200  mysql-slowquery.log >> combine.log
```

