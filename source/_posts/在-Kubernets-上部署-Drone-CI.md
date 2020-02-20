---
title: 在 Kubernets 上部署 Drone CI
date: 2020-02-20 17:11:58
tags:
- helm
- kubernets
- k8s
categories: kubernets
thumbnail: https://s2.ax1x.com/2020/02/20/3mAf6f.png
---

Drone 是一个非常轻量的 CI 工具，相比 Jenkins 繁杂的插件、配置、维护，Drone 更简单易用

在上一篇文章《[在 Kubernets 上安装 Helm](post/在-Kubernets-上安装-Helm)》中，我已经安装好了 Helm，这次将使用 Helm 来安装 Drone CI

### 新建 GitHub 应用

我这里使用了 GItHub 来作为代码仓库和授权服务，你可以使用任意其他的代码仓库，过程大体类似

登录 GitHub，在 https://github.com/settings/applications/new 新建一个应用。

![](https://s2.ax1x.com/2020/02/20/3mpKbR.png)

创建成功后会得到一个`clientId`和`clientSecret`，记录好以备后用

部署要求

### 安装 Drone CI

打开 Drone 在 Helm 下的安装文档 (https://hub.kubeapps.com/charts/stable/drone)[https://hub.kubeapps.com/charts/stable/drone]，在提示下进行安装

首先通过 helm 安装 drone，指明命名空间为 drone，其名字为 drone

```bash
$ helm install --name drone --namespace drone stable/drone
```

这时会提示报错，要求你创建一个 `secret`，执行以下命令创建，注意将其中的 `clientSecret` 替换为刚刚在 GitHub 得到的 `clientSecret` 

```bash
$ kubectl create secret generic drone-server-secrets \
      --namespace=drone \
      --from-literal=clientSecret="XXXXXXXXXXXXXXXXXXXXXXXX"
```

接下来更新 drone，注意将其中的 `clientID` 替换为刚刚在 GitHub 得到的 `clientID `

```bash
$ helm upgrade drone \
  --reuse-values --set 'service.type=LoadBalancer' \
  --set 'service.loadBalancerIP=2.1.60.3' --set 'sourceControl.provider=github' \
  --set 'sourceControl.github.clientID=XXXXXXXX' \
  --set 'sourceControl.secret=drone-server-secrets' --set 'server.host=drone.example.com' \
  stable/drone
```

查看 drone 的状态

```bash
$ kubectl get pods -n=drone -o wide

NAME                                  READY   STATUS    RESTARTS   AGE
drone-drone-server-78c7c76b64-mqvbm   1/1     Running   0          175m
```

pods 可能会遇到因未分配 volume 而创建失败的情况，需要手动为其分配下 PVC

我使用的服务商是 AWS，所以我可以直接使用 EBS 或 EFS 来作为我的 StorageClass 提供商，最终我还是使用了 EFS，因为 EBS 虽然方便但有丢丢坑（需要我修改 node name）

### 访问

可以为你的 Drone CI 创建互联网访问入口（Ingress Controller），然后访问 Drone CI 所在的网址，这时会向 GitHub 申请授权，同意后就可以开始用户啦

![](https://s2.ax1x.com/2020/02/20/3mAFOS.png)

