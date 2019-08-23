---
title: Firmoo 理想化分站架构
date: 2019-08-23 15:43:16
tags:
---

## Firmoo 分站建设需求：

> 1. 因为西语是第二大流行语言，许多国家在使用西语，所以要开设西语站
>
> 2. 可能要开设德国站，要本土化，服务器等部署在德国

需求 1 指的是「西语」站点，针对的是「语种」

需求 2 指的是「德国」站点，针对的是「国家」 



## 语种与国家的基本关系：

> 一个语种可能同时被多个国家使用，一个国家可能同时存在多个语种



### eBay 全球站点建设：语种与国家对应关系

| 国际分站 | 语种 | 站点 |
| :------------ | :----------- | :----------------------------------------------------------- |
|  eBay 美国     |  英语         |  [www.ebay.com](http://rover.ebay.com/rover/1/711-53200-19255-0/1?icep_ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&ipn=psmain&icep_vectorid=229466&kwid=902099&mtid=824&kw=lg)![img](https://rover.ebay.com/roverimp/1/711-53200-19255-0/1?ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&mpt=[CACHEBUSTER]) |
| eBay 英国     | 英语         | [www.ebay.co.uk](http://rover.ebay.com/rover/1/710-53481-19255-0/1?icep_ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&ipn=psmain&icep_vectorid=229508&kwid=902099&mtid=824&kw=lg)![img](https://rover.ebay.com/roverimp/1/710-53481-19255-0/1?ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&mpt=[CACHEBUSTER]) |
| eBay 澳大利亚 | 英语         | [www.ebay.au](http://rover.ebay.com/rover/1/705-53470-19255-0/1?icep_ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&ipn=psmain&icep_vectorid=229515&kwid=902099&mtid=824&kw=lg)![img](https://rover.ebay.com/roverimp/1/705-53470-19255-0/1?ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&mpt=[CACHEBUSTER]) |
| eBay 印度     | 英语         | [www.ebay.in](http://www.ebay.in/)                           |
| eBay 爱尔兰   | 英语         | [www.ebay.ie](http://rover.ebay.com/rover/1/5282-53468-19255-0/1?icep_ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&ipn=psmain&icep_vectorid=229543&kwid=902099&mtid=824&kw=lg)![img](https://rover.ebay.com/roverimp/1/5282-53468-19255-0/1?ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&mpt=[CACHEBUSTER]) |
| eBay 新加坡   | 英语         | [www.ebay.com.sg](http://www.ebay.com.sg/)                   |
| eBay 马来西亚 | 英语         | [www.ebay.com.my](http://www.ebay.com.my/)                   |
| eBay 菲律宾   | 英语         | [www.ebay.ph](http://www.ebay.ph/)                           |
| eBay 中国     | 中文         | [www.ebay.cn](http://www.ebay.cn/)                           |
| eBay 香港     | 中文         | [www.ebay.com.hk](http://www.ebay.com.hk/)                   |
| eBay 台湾     | 中文         | [www.ebay.com.tw](http://www.ebay.com.tw/)                   |
| eBay 阿根廷   | 西班牙语     | [www.mercadolibre.com.ar](http://www.mercadolibre.com.ar/)   |
| eBay 西班牙   | 西班牙语     | [www.ebay.es](http://rover.ebay.com/rover/1/1185-53479-19255-0/1?icep_ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&ipn=psmain&icep_vectorid=229501&kwid=902099&mtid=824&kw=lg)![img](https://rover.ebay.com/roverimp/1/1185-53479-19255-0/1?ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&mpt=[CACHEBUSTER]) |
| eBay 墨西哥   | 西班牙语     | [www.mercadolibre.com.mx](http://www.mercadolibre.com.mx/)   |
| eBay 奥地利   | 德语         | [www.ebay.at](http://rover.ebay.com/rover/1/5221-53469-19255-0/1?icep_ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&ipn=psmain&icep_vectorid=229473&kwid=902099&mtid=824&kw=lg)![img](https://rover.ebay.com/roverimp/1/5221-53469-19255-0/1?ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&mpt=[CACHEBUSTER]) |
| eBay 德国     | 德语         | [www.ebay.de](http://rover.ebay.com/rover/1/707-53477-19255-0/1?icep_ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&ipn=psmain&icep_vectorid=229487&kwid=902099&mtid=824&kw=lg)![img](https://rover.ebay.com/roverimp/1/707-53477-19255-0/1?ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&mpt=[CACHEBUSTER]) |
| eBay 瑞士     | 德语         | [www.ebay.ch](http://rover.ebay.com/rover/1/5222-53480-19255-0/1?icep_ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&ipn=psmain&icep_vectorid=229536&kwid=902099&mtid=824&kw=lg)![img](https://rover.ebay.com/roverimp/1/5222-53480-19255-0/1?ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&mpt=[CACHEBUSTER]) |
| eBay 法国     | 法语         | [www.ebay.fr](http://rover.ebay.com/rover/1/709-53476-19255-0/1?icep_ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&ipn=psmain&icep_vectorid=229480&kwid=902099&mtid=824&kw=lg)![img](https://rover.ebay.com/roverimp/1/709-53476-19255-0/1?ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&mpt=[CACHEBUSTER]) |
| eBay 荷兰     | 菏兰语       | [www.ebay.nl](http://rover.ebay.com/rover/1/1346-53482-19255-0/1?icep_ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&ipn=psmain&icep_vectorid=229557&kwid=902099&mtid=824&kw=lg)![img](https://rover.ebay.com/roverimp/1/1346-53482-19255-0/1?ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&mpt=[CACHEBUSTER]) |
| eBay 波兰     | 波兰语       | [www.ebay.pl](http://www.ebay.pl/)                           |
| eBay 比利时   | 荷兰语及法语 | [www.ebay.be / www.benl.ebay.be/](http://rover.ebay.com/rover/1/1553-53471-19255-0/1?icep_ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&ipn=psmain&icep_vectorid=229522&kwid=902099&mtid=824&kw=lg)![img](https://rover.ebay.com/roverimp/1/1553-53471-19255-0/1?ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&mpt=[CACHEBUSTER]) |
| eBay 加拿大   | 英语及法语   | [www.ebay.ca / www.cafr.ebay.ca](http://rover.ebay.com/rover/1/706-53473-19255-0/1?icep_ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&ipn=psmain&icep_vectorid=229529&kwid=902099&mtid=824&kw=lg)![img](https://rover.ebay.com/roverimp/1/706-53473-19255-0/1?ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&mpt=[CACHEBUSTER]) |
| eBay 巴西     | 葡萄牙语     | [www.mercadolivre.com.br](http://www.mercadolivre.com.br/)   |
| eBay 意大利   | 意大利语     | [www.ebay.it](http://rover.ebay.com/rover/1/724-53478-19255-0/1?icep_ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&ipn=psmain&icep_vectorid=229494&kwid=902099&mtid=824&kw=lg)![img](https://rover.ebay.com/roverimp/1/724-53478-19255-0/1?ff3=1&pub=5575092732&toolid=10001&campid=5337890769&customid=&mpt=[CACHEBUSTER]) |
| eBay 日本     | 日语         | [www.sekaimon.com](http://www.sekaimon.com/)                 |




### Amazon 全球站点建设：语种与国家对应关系

| 国际分站      | 语种     | 站点                                                         |
| ------------- | -------- | ------------------------------------------------------------ |
| Amazon 美国   | 英语     | [www.amazon.com](https://www.amazon.com) |
| Amazon 英国   | 英语     | [www.amazon.co.uk](https://www.amazon.co.uk)|
| Amazon 加拿大   | 英语及法语     | [www.amazon.ca](https://www.amazon.ca/)|
| Amazon 中国   | 中文     | [www.amazon.cn](https://www.amazon.cn) |
| Amazon 西班牙 | 西班牙语 | [www.amazon.es](https://www.amazon.es)|
| Amazon 德国   | 德语     | [www.amazon.de](https://www.amazon.de)|



可以看出 eBay 与 amazon 的分站架构类似，都是以国家为分站建设单位，每个分站又可以选择多种语言。

**总结：Firmoo 分站建设应以国家为单位，而不是以语种为单位。语种应作为每个国家分站下的可切换选项**



## 用户和产品：

使用同一个 Facebook 账户登录不同的 eBay 分站，可以看到用户数据是共享的。

登录了一个  eBay 分站后，打开其他 eBay 分站，可以看到没有自动登录，大概是因为同源策略。

Amazon、eBay 各站的产品资源不共享，有较高的本土化需求。

Firmoo 的产品比较通用，本土化的需求基本只体现在产品的名称、描述、参数名称上。

Firmoo 的用户不像其他电商网站，有很多回头客，大部分用户可能购买一次后一两年之内都不会再来买，少部分用户可能会为他的朋友、亲人买。Firmoo 的用户可能也不会同时登陆多个分站下单。

总的来说，Firmoo 的产品需要在多个站点间共享，Firmoo 的用户





## 网站规模：

eBay、amazon 有极大的规模和流量，可以支撑接近理想化的大规模分站部署。

对于中小型电商网站，要部署理想化的分站，即使只部署一个，可能都需要很高的成本。



## Firmoo 的分站站点建设方案：

1. 数据库部分分库
2. 数据库翻译
3. 国际化语言包
4. 代码模块化管理
5. 每个站点拥有自己的代码仓库及服务器资源



### 数据库部分分库 —— 统一管理通用资源：

### 数据库翻译 —— 两种可选的方案：

### 国际化语言包 —— i18n：

### 代码模块化管理 —— git submodule：

### 每个站点拥有自己的代码仓库及服务器资源 —— 差异化、本地化：