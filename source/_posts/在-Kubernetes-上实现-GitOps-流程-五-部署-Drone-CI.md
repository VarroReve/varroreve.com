---
title: 在 Kubernetes 上实现 GitOps 流程(五) - 部署 Drone CI
date: 2020-09-25 11:08:54
tags:
- AWS EKS
- Kubernetes
- GitOps
---

在之前的文章 [在 Kubernets 上部署 Drone CI](/post/在-Kubernets-上部署-Drone-CI) 中, 介绍了使用 helm 部署 Drone CI, 这次介绍使用 GitOps 的方式来部署 Drone CI

之所以到了本节才部署 Drone CI, 是因为 Drone CI 会提供一个 Web 界面, 而我希望这个页面可以在公网中访问, 并为其配置证书, 这就要使用前两节部署的 Ingress Controller 和 Cert Manager

<!-- more -->

### 部署

Drone CI 属于 GitOps 的一个环节, 自然也应部署在 `gitops` 命名空间下

参照  [在 Kubernets 上部署 Drone CI](/post/在-Kubernets-上部署-Drone-CI) 中的方式, 创建一个 GitHub 应用并保存 `Client ID, Client Secret`, 如果你用的代码仓库是 GitLab 或其他, 也同理

新建 hr `releases/git-ops/drone/helmrelease.yaml`:

注意将代码中的域名、秘钥换为你自己的

```yaml
---
apiVersion: helm.fluxcd.io/v1
kind: HelmRelease
metadata:
  name: drone
  namespace: gitops
  annotations:
    fluxcd.io/automated: "false"
    filter.fluxcd.io/chart-image: semver:~1.9
spec:
  releaseName: drone
  chart:
    repository: https://charts.drone.io
    name: drone
    version: 0.1.7
  values:
    env:
      DRONE_SERVER_HOST: #<你的域名>
      DRONE_SERVER_PROTO: https
      DRONE_GITHUB_CLIENT_ID: #<你的 GitHub Client ID>
      DRONE_GITHUB_CLIENT_SECRET: #<你的 GitHub Secret ID>
      DRONE_RPC_SECRET: c27d9e98d7ec90e2 #一个随机秘钥, 可以自定义
    ingress:
      enabled: true
      annotations:
        kubernetes.io/ingress.class: nginx
        cert-manager.io/cluster-issuer: "letsencrypt-prod"
      hosts:
        - host: #<你的域名>
          paths:
            - "/"
    tls:
      - secretName: drone-tls
        hosts:
          - #<你的域名>
```

之后提交 commit 并推送到远程仓库, 稍微等待下后, 查看 Drone:

```bash
$ kubectl get pods -n gitops

NAME                             READY   STATUS    RESTARTS   AGE
drone-97d6fc444-vdvxc            1/1     Running   0          45s
flux-ffc78f966-2gnpj             1/1     Running   1          2d22h
helm-operator-6fd6b7fbfc-xgcrf   1/1     Running   0          2d22h
memcached-7dd5ff9dcf-rcpkg       1/1     Running   0          2d22h
```

Drone 已成功部署, 查看 Ingress:

```bash
$ kubectl get ingress -A

NAMESPACE   NAME    HOSTS               ADDRESS                                                                   PORTS     AGE
gitops      drone   drone.xxxxxx.cn     xxxxxxxxxxxxxxxx.ap-east-1.elb.amazonaws.com                              80, 443   5h42m
```

可以看到 Drone 的 Ingress 资源已创建, 并且已通过 AWS 创建了一个经典网络负载均衡器(CLB), 接下来将这个域名 CNAME 到负载均衡器的地址上并访问, 可以看到 Ingress 已正常工作, 并且 Cert Manager 已为该域名申请 Let's Encrypt 证书(有效期为三个月, 在第三个月时 Cert Manager 会自动为证书续期)

![](https://s1.ax1x.com/2020/09/25/0CdnN6.png)

### 结语

至此, EKS + Git + Helm + DroneCI + FluxCD 的 GitOps 环境已搭建完成, 接下来将通过 GitOps 的方式, 将一个 Demo 项目部署到 `staging`、`test` 两个环境中