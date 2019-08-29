---
title: Firmoo 理想化分站架构
date: 2019-08-23 15:43:16
tags:
---

## Firmoo 分站建设需求

> 1. 因为西语是第二大流行语言，许多国家在使用西语，所以要开设西语站
>
> 2. 可能要开设德国站，要本土化，服务器等部署在德国

需求 1 指的是「西语」站点，针对的是「语种」

需求 2 指的是「德国」站点，针对的是「国家」 



## 语种与国家

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



## 用户和产品



### 用户数据

使用同一个 Facebook 账户登录不同的 eBay 分站，可以看到用户数据是共享的。

登录了一个  eBay 分站后，打开其他 eBay 分站，可以看到没有自动登录，大概是因为同源策略。



### 产品

Amazon、eBay 各站的产品资源不共享，有较高的本土化需求。

Firmoo 的产品比较通用，本土化的需求基本只体现在产品的名称、描述、参数名称上。



### 总结

总的来说，eBay 和 Amazon 的用户数据是共享的，而产品数据应该是不共享的。根据 Firmoo 的定位和需求，Firmoo 分站的产品和用户账号需要在多个站点间共享，但用户的收货地址、处方、历史订单等是否也有必要共享？



## Firmoo 的分站站点建设方案

1. 数据库部分分库
2. 数据库翻译
3. 国际化语言包
4. 代码模块化管理
5. 每个站点拥有自己的代码仓库及服务器资源



### 数据库部分分库 —— 区别、统一管理资源

对于产品、用户数据，我们需要在不同站点间共享、统一管理；对于其他资源，我们希望每个分站有能力独自管理。

![](https://s2.ax1x.com/2019/08/23/mDRBQK.png)

每有一个国家的分站，就为这个分站分配一个新的数据库。对于邮件、优惠券、营销、统计等模块，这些分站数据库拥有独自的数据表；对于用户、产品模块，分站共用主站数据库。



### 国际化 —— i18n

像 eBay 加拿大站，用户可以选择使用英语或法语。

对应到 Firmoo，可能是这样的场景：Firmoo 美国站同时使用英语及西语，英语为美国站普通用户服务，西语为美属波多黎各用户服务。而 Firmoo 西班牙站只使用西语。

要做到一个站点提供多种语言选项，就需要「代码层面翻译」与「数据库层面翻译」。

#### 代码层面翻译

前端展示给用户的静态界面、返回给用户的提示，这些都在代码层面使用语言包完成。根据用户不同的偏好设置，展示不同的语言。

#### 数据库层面翻译

像产品描述、国家信息等存储在数据库中的信息，做多语言翻译有两种可选方案：

1. 使用现有的方案

   比如说我们有一行「产品表」，其中「产品名称」、「产品描述」这两个字段需要作多语言翻译，那么我们就将这两个字段抽离到一张专门的「产品翻译表」中，在这个表中为这两字段做多语言翻译。这是我们目前存在的方案。

2. 使用支持多语言的字段存储方式

   MySQL 5.7 以上支持 JSON 字段存储，那么我们可以将「产品名称」字段设为 JSON，并采用以下方式存储多语言翻译

   ```json
   {
       "zh-CN": "眼镜",
       "en": "glasses",
       "es": "gafas"
   }
   ```

   

### 代码模块化管理 —— git submodule

分站和主站的功能、业务大体上是相似的，但会存在差异化的需求。

如果直接复制一份主站代码作为分站的代码，那么当一个全站通用的功能上线时，我们就需要更新每个分站的代码仓库，分站越多，维护量越大。

Git Submodule 可以解决这个问题。

我们可以将主站与分站通用的代码抽离出来，作为一个单独的代码仓库，也就是子模块。主站与分站代码仓库都分别依赖这个子模块，这样当要上线一个全站通用的功能时，只需要更新子模块的代码，主站和分站的功能就会自动更新。而对于差异化的功能，只需要写在站点各自的代码仓库即可。



### 分站的生产环境架构：
