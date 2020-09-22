---
title: '在 Kubernetes 上实现 GitOps 流程(一)'
date: 2020-09-22 09:19:02
tags:
- AWS EKS
- Kubernetes
- GitOps
---

### 什么是 GitOps

> 简单来说，GitOps 是实现持续交付的一种方式。通过使用Git 作为唯一的事实来源，去声明基础架构以及应用负载所期望达到的最终运行状态。GitOps 持续交付工具会实时观察声明式基础架构本身以及运行其上的工作负载状态，并与保存在 Git 中所期望的配置和部署文件比较差异。如果有差异，则会自动触发一系列预先配置好的自动更新或回滚策略，以确保基础架构和工作负载始终按照 Git 中的配置文件及部署文件所描述的期望状态运行。
<!-- more -->

### GitOps 与 DevOps 有什么区别

> 随着 DevOps 的发展以及采用 DevOps 思维方式的组织不断增多，DevOps 的许多不同方面都日趋成熟。随着DevOps 的成熟，在概念和思维方式（DevSecOps、AIOps、SecOps 等）领域也在不断发展。GitOps 是DevOps 中的另一个萌芽概念，**其根源在于使开发人员能够使用 Git 创建 CI/CD 来自动化多云和多容器编排集群的开发和运营。**

### 本文目的

- 在 AWS EKS 上快速实现 Git + Helm + DroneCI + FluxCD 的 GitOps 流程
- 将一个 Demo 项目（本博客）以 GitOps 的方式分别部署在测试、预发、生产环境中
- 对 Pod 和集群进行自动扩展
- 使用 EFK 收集、处理日志
- 部署 Prometheus & Grafana 监控

### 参考资料

- [在 AWS 中国区 EKS 上以 GitOps 方式构建 CI/CD 流水线](https://aws.amazon.com/cn/blogs/china/build-ci-cd-pipeline-in-gitops-on-aws-china-eks/)
- [GitOps丨一种实现云原生的持续交付模型](http://choerodon.io/zh/blog/gitops/)
- [GitOps - EKSctl](https://eksctl.io/usage/gitops/)
- [The GitOps operator for Kubernetes](https://fluxcd.io/)
