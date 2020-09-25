---
title: '在 Kubernetes 上实现 GitOps 流程(三) - 部署 Ingress Controller'
date: 2020-09-25 9:44:55
tags:
- AWS EKS
- Kubernetes
- GitOps
---

### ALB 与 CLB

Ingress 是对集群中服务的外部访问进行管理的 API 对象, 可以结合云服务商提供的负载均衡器使用

<!-- more -->

EKS 集群天然支持 AWS Application Load Balancer (ALB), 但是 [ALB Ingress Controller](https://github.com/kubernetes-sigs/aws-alb-ingress-controller) 有个问题, 就是多个 Service 不能复用同一个 alb, 这就导致如果预发/测试环境中有很多项目, 就需要创建很多 alb, 成本较高. ALB Ingress Controller 的开发组也正在解决这个问题, 详见 [Ingress Group Feature Testing #914 ](https://github.com/kubernetes-sigs/aws-alb-ingress-controller/issues/914)

基于以上原因, 所以我选择使用 [Nginx Ingress Controller](https://kubernetes.github.io/ingress-nginx/), 好消息是使用 Nginx Ingress Controller 创建 Service 时会自动创建 AWS Classic Load Balancer (CLB), 并且多个 Service 可以复用一个 CLB, 达到节约成本的目的. (虽然不知道为什么会这样, 我也没找到相关文档)

### Helm Release

使用 Helm 部署程序到集群大家应该都熟悉, Flux CD 定义了一个叫做 Helm Release 的自定义资源 (CRD), 简称 HR, Flux 使用 HR 来接管常规的 Helm 操作, 现在就使用 HR 来部署 Nginx Ingress Controller

在配置仓库下新建 `releases/kube-system/ingress-nginx/helmrelease.yaml` 文件, 并写入以下内容:

```yaml
---
apiVersion: helm.fluxcd.io/v1
kind: HelmRelease
metadata:
  name: ingress-nginx
  namespace: kube-system
  annotations:
    fluxcd.io/automated: "false"
spec:
  releaseName: ingress-nginx
  chart:
    repository: https://kubernetes.github.io/ingress-nginx
    name: ingress-nginx
    version: 2.11.2
  values:
    repository: us.gcr.io/k8s-artifacts-prod/ingress-nginx/controller
    tag: "v0.34.1"
```

目录树:

```
│  .gitignore
│
├─namespaces
│      gitops.yaml
│      prod.yaml
│      staging.yaml
│      test.yaml
│
└─releases
    └─kube-system
        └─ingress-nginx
                helmrelease.yaml
```

之后提交 commit 并推送到远程仓库, 稍微等待下后, 查看 Ingress Controller:

```bash
$ kubectl get pods -n kube-system

NAME                                        READY   STATUS    RESTARTS   AGE
aws-node-5kg24                              1/1     Running   0          2d19h
aws-node-qd48f                              1/1     Running   0          2d19h
coredns-7dc7d9fb5d-9p84t                    1/1     Running   0          2d19h
coredns-7dc7d9fb5d-n6xs4                    1/1     Running   0          2d19h
ingress-nginx-controller-77f5884bdd-8f7cd   1/1     Running   0          46s
kube-proxy-6lw66                            1/1     Running   0          2d19h
kube-proxy-vqfz7                            1/1     Running   0          2d19h
```

可以看到 Nginx Ingress Controller 已经成功部署

关于 Helm Release 更多信息和进阶使用, 可以参考 Flux 的 [官方文档](https://docs.fluxcd.io/projects/helm-operator/en/stable/)