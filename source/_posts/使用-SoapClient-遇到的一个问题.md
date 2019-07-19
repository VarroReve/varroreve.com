---
title: 使用 SoapClient 遇到的一个问题
date: 2019-07-16 09:45:50
tags:
- php
- 坑
---

由于业务需求，需要对接一个合作商提供的 WebService。这个 WebService 提供了正式和测试地址，但在使用 SoapClient 连接测试环境时却总是连接到正式地址。
