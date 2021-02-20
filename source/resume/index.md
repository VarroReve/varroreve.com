---
title: Varro 的简历
date: 2019-07-13 09:17:16
---

## 自我介绍

你好，我是 varro ，一名生于 1994 年，具备四年工作经验的软件工程师。这是我的 [在线简历](https://varroreve.com/resume)，以及由 CI 渲染的 [PDF 版本]()。

我在 2013 - 2017 年间在重庆科技学院学习机械电子工程，大四时开始自学 PHP，毕业后从事后端开发。2019 年向云服务运维、DevOps 转型。目前是一名自由职业者，正在深入学习 **Kubernetes**。

我的职业规划大多基于兴趣驱动，善于独立思考、钻研问题的更优解，推崇最佳实践。对自己的定位是一位终身学习者，一位 [终身编程者](https://learnku.com/lifecoder/t/29391)。

## 技能与程序员修养

1. 具备 Kubernetes 集群维护经验，熟练使用 Docker、Helm， 熟悉 Helm、CNCF 生态。
2. 具备 AWS 云服务产品运维经验， 有部分 GCE 经验。
3. 具备基于 Prometheus Stack 与 AWS CloudWatch 的监控预警实践经验。
4. 具备 Git workflows 与 DevOps 实践经验，擅长使用 Drone CI、GitLab CI。
5. 拥有较多 PHP 后端开发经验，熟悉常见业务逻辑场景的规划、设计。
6. 拥有一些 Android（Java）开发经验，拥有 Google Play Apps 运营经验。
7. 关注技术动向，社区活跃，喜欢在 GitHub 搜寻、尝试各种开源项目。
8. 重度 Google 用户，无英文文档阅读障碍，习惯通过社区（GitHub Issues 等）定位、解决问题。
9. 良好的代码结构、命名、文档编写、图表绘制习惯，遵从 [约定式提交](https://www.conventionalcommits.org/zh-hans/v1.0.0-beta.4/)、[中文文案排版指北](https://github.com/sparanoid/chinese-copywriting-guidelines) 等规范。

##  <a name="近期工作">近期工作</a>

- **将传统应用由 AWS EC2 迁移至 AWS EKS**
  部署了适用于生产环境的 K8S 集群，将公司十年间来运行的工作负载全部迁移至 AWS EKS。有效提高系统资源利用率，大幅降低多个服务的编排部署难度。

- **搭建并优化 Prometheus 等监控系统和告警规则**

  为 K8S 搭建 Prometheus 和 Grafana。根据业务需要，编写 Prometheus Exporters、Alert Rules 和 Grafana Dashboards。

  接入AWS CloudWatch 指标作为辅助告警项。

- **为 K8S 集群、业务应用搭建日志体系**

  搭建 EFK 统一收集访问日志、应用日志、业务日志，编写 Kibana Dashboards 提供可视化数据分析。

  部署并使用 Sentry 捕获应用异常、K8S Event。

- **传统应用容器化及无状态化、创建并维护 Helm Charts**
  为传统应用编写 DockerFile、Drone CI、GitLab CI 文件，将其打包为 Docker Image。

  针对后端服务的日志、存储、Session 等作无状态化改造，将这些文件收集到云端或缓存系统，使服务可弹性伸缩。

  根据业务需要，创建并维护业务应用所需的 Helm Charts。

- **编写集群相关文档、结构图**

  为 K8S 集群编写说明文档、上线步骤、维护规范，绘制集群结构图、AWS VPC 结构图。


## 个人项目

### [GooglePlay Apps](https://play.google.com/store/apps/details?id=com.pictext.followersedit)

我与三位好友在 GooglePlay 上架了数个 [社交工具类应用](https://play.google.com/store/apps/details?id=com.pictext.followersedit)，通过帮助用户在 Instagram、TikTok 上获得更多关注者和赞，而从中获取收益。在短时间内积累了 10W+ 用户。

我主要负责 PHP API 后端开发、AWS 云服务运维、英文 Email 客服，其次负责 Android（Java）App 开发。

目前在为应用接入 Amazon Pay，尝试上架到 Amazon App Store。

### [Laracasts-Translation](https://github.com/VarroReve/laracasts-translation)

Laracasts 是 Laravel（最流行的 PHP 框架） 官方创办的视频教学网站，涵盖了 Laravel、Vue、Testing 等前沿技术。由于是国外网站、英语解说，所以自己翻译了部分视频，后因时间问题弃更。目前在 [GithHub](https://github.com/VarroReve/laracasts-translation) 上拥有 30 Stars。

## 任职历史

|      公司      |                 岗位                  |       时间       |
| :------------: | :-----------------------------------: | :--------------: |
|   [自由职业](#自由职业)   | 全栈开发（Android + PHP + Kubernetes） |  2020.11 ~ 至今  |
|    [Firmoo](#Firmoo)        | 高级 PHP 工程师 -> DevOps、运维工程师 | 2019.3 ~ 2020.11 |
|  [重庆百分网络](#重庆百分网络)   |            高级 PHP 工程师            | 2018.10 ~ 2019.1 |
|  [重庆玖万科技](#重庆玖万科技)   |              PHP 工程师               | 2018.3 ~ 2018.9  |
| [重庆我请客科技](#重庆我请客科技)   |              PHP 工程师               | 2017.6 ~ 2018.1  |

### <a name="自由职业">自由职业</a>

从 Firmoo 离职后，我投入更多时间到 Google Play Apps 的开发运营中，同时承接了 Firmoo 的外包项目：部署一个适用于生产环境的 K8S 集群，然后将所有的工作负载迁移到集群上。涉及到的具体事项即是上文中的 [近期工作](#近期工作)，目前该项目已进入测试验收阶段。

### <a name="Firmoo">Firmoo</a>

公司业务方向为跨境电商，主营在线眼镜销售，后拓展到珠宝行业。近年来由于方向调整及疫情影响，公司业务量暴涨。我起初为后端团队主力开发，负责制定业务的技术方案并实现；后转岗运维，负责 AWS 云服务运维、DevOps。

- **升级后端技术栈软件版本**

  公司所以使用的 PHP、Laravel、Composer 依赖包版本三年来从未升级，导致无法再使用新特性、新的依赖包，性能也受到制约。

  我升级了 PHP（5.6 -> 7.2）、Laravel 框架（5.2 -> 5.8）及各个依赖包的版本，使其可以更好得适应 PHP 生态圈，获得最新版本的开源项目支持。

- **为 firmoo.com 做多语种国际化支持**

  [firmoo.com](http://firmoo.com/) 是一个面向世界各国的在线眼镜销售网站，其各类文案原先只支持英语。我设计了 firmoo.com 的国际化方案，对前端、后端、管理后台等服务进行改造，引入翻译工作台以提升业务团队的协同翻译效率，最终使 firmoo.com 获得西班牙语、德语、法语等其他语种支持。

- **为 firmoo.com 建设国际化分站**

  [firmoo.com](http://firmoo.com/) 的主要用户群体分布在北美，为向欧澳南美扩张业务，公司要求在不同国家建设分站，以推行符合当地政策的营销手段。建立分站的主要难点在于：

  - 在不同分站间，用户的账号数据通用，但其他数据（如订单、收货地址）不通用

  - 同一款产品可能会上架到不同分站，但拥有不同的属性（如价格、商品信息、SKU、库存、发货方式等）

  - 由于运营政策不同，分站与主站间在某些功能、细节上有较大差异，但整体上又比较相似

  - 分站要部署在当地的 AWS 区域，而核心的 RDS 数据库仍部署在美国，服务与数据库通信有较大延迟

  针对数据库中数据通用不通用的问题，我采用行级别 + 表级别数据隔离的方式来实现，通过定义数据库资源的模型关联，极大减少了因建设分站带来的巨量业务代码改造。

  针对产品在不同国家有不同营销政策的问题，我设计了产品池，将产品的 “商品属性” 与 “产品属性” 分离开来，不同分站的产品有相同的 “产品属性”，但有着不同的 “商品属性” ，运营团队可在后台方便得管理产品上架。

  针对代码差异化问题，我以该方式解决：前端项目采用 Git Submodule 实现差异化样式展示；不同分站使用相同的 API 代码、不同的 `env` 环境变量来部署工作负载；改造原有的管理后台，使其支持多站点管理。

  针对服务器部署问题，我最终采用了以下方式：前端服务部署在当地，后端服务部署在美国（靠近 RDS），通过 AWS Backbone Network 及缓存服务将延迟降低到业务方可接受范围内。

  最终，firmoo.com 通过此方案上线了英国、西班牙、澳大利亚、法国、德国等分站。

- **常规运维科学上网**

  服务器权限、数据库

- **AWS VPC EC2 改造**

  公司的工作负载运行在 AWS 之上，对 VPC、EC2 的规划使用存在许多误区：

  - 所有的工作载荷都运行在公有子网下并暴露了服务器真实 IP 地址
  
  - VPC CIDR 设置不合理，不同 AWS Region 下的 VPC 间无法 peering
  
  - 只启用了一个 AWS 高可用区、没有做负载均衡、没有做弹性伸缩
  
  - 服务之间通过对方公网域名相互访问，没有做服务发现

  - 安全组、ACL 不完善，服务器与数据库有潜在安全风险

  针对上述问题，我基于最佳实践在 AWS 另一个 Region 部署了改造后的 VPC，优化了服务结构。后因 AWS RDS 数据库换区带来的停机问题，以及 Kubernetes 计划的推行，本次改造最终没有上线。

- GitOps

  基于 GitOps 思想，通过调整配置或引入新工具，持续优化各团队的开发工作流，包括 CI pipelines 通知、队列任务与 Cron Jobs 通知、AWS SNS、K8S Event 等。为开发工程师提供技术支持，包括开发与系统工具的使用、文档编写、故障排查等，提高开发效率。

- 监控告警

- 测试环境集群

- ```
  
  ```





### <a name="重庆百分网络">重庆百分网络</a>

### <a name="重庆玖万科技">重庆玖万科技</a>

### <a name="重庆我请客科技">重庆我请客科技</a>

## 联系我
