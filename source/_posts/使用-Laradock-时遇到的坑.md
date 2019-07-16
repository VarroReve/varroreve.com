---
title: 使用 Laradock 时遇到的坑
date: 2019-07-15 17:27:08
tags:
- laravel
- laradock
- docker
category:
- laravel
---

**Laradock 的坑太多了，把遇到的一一总结下。**
<!-- more -->


### 执行 INSTALL_PHPREDIS 时报错

> Step 93/217 : RUN if [ ${INSTALL_PHPREDIS} = true ]; then apt-get install -yqq php-redis ;fi
  ---> Running in d5e2e70b87ce
  E: Failed to fetch http://ppa.launchpad.net/ondrej/php/ubuntu/pool/main/p/php-redis/php-redis_4.2.0-1+ubuntu16.04.1+deb.sury.org+1_amd64.deb 404 Not Found
  
> E: Unable to fetch some archives, maybe run apt-get update or try with --fix-missing?
  ERROR: Service 'workspace' failed to build: The command '/bin/sh -c if [
  ${INSTALL_PHPREDIS} = true ]; then apt-get install -yqq php-redis ;fi' returned a non-zero code: 100
  Failed to deploy 'Compose: docker-compose.yml': docker-compose process finished with exit code 1

解决办法

```bash
docker-compose build --no-cache workspace php-fpm
```

### 执行 INSTALL_IMAP 时报错

> Step 66/217 : RUN if [ ${INSTALL_IMAP} = true ]; then     apt-get install -y php${LARADOCK_PHP_VERSION}-imap ;fi
   ---> Running in 1ee4bf1b1e70
  Reading package lists...
  Building dependency tree...
  Reading state information...
  The following additional packages will be installed:
    libc-client2007e mlock
  Suggested packages:
    uw-mailutils
  The following NEW packages will be installed:
    libc-client2007e mlock php7.2-imap
  0 upgraded, 3 newly installed, 0 to remove and 17 not upgraded.
  Need to get 617 kB of archives.
  After this operation, 1,651 kB of additional disk space will be used.
  Get:1 http://archive.ubuntu.com/ubuntu xenial/universe amd64 mlock amd64 8:2007f~dfsg-4 [12.0 kB]
  Get:2 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libc-client2007e amd64 8:2007f~dfsg-4 [577 kB]
  Err:3 http://ppa.launchpad.net/ondrej/php/ubuntu xenial/main amd64 php7.2-imap amd64 7.2.16-1+ubuntu16.04.1+deb.sury.org+1
    404  Not Found
  E: Failed to fetch http://ppa.launchpad.net/ondrej/php/ubuntu/pool/main/p/php7.2/php7.2-imap_7.2.16-1+ubuntu16.04.1+deb.sury.org+1_amd64.deb  404  Not Found
  
>  E: Unable to fetch some archives, maybe run apt-get update or try with --fix-missing?
  Fetched 589 kB in 3s (176 kB/s)
  Service 'workspace' failed to build: The command '/bin/sh -c if [ ${INSTALL_IMAP} = true ]; then     apt-get install -y php${LARADOCK_PHP_VERSION}-imap ;fi' returned a non-zero code: 100

解决办法

```bash
docker-compose build --no-cache workspace php-fpm
```