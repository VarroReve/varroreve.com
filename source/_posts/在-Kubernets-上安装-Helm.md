---
title: 在 Kubernets 上安装 Helm
date: 2020-02-19 17:05:25
tags:
- helm
- kubernets
- k8s
categories: kubernets
thumbnail: https://s2.ax1x.com/2020/02/20/3mAW1P.png
---

### 安装要求

- Kubernetes 1.5 以上版本
- 集群可访问到的镜像仓库
- 执行 Helm 命令的主机可以访问到 Kubernetes 集群

### 安装步骤

这里安装的版本是 helm3，而 helm3 已完全移除了 tiller，所以不必再执行 tiller 相关操作

```bash
$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
$ chmod 700 get_helm.sh
$ ./get_helm.sh
```

### ~~赋予 tiller 权限~~（在 helm3 中已废弃）

```bash
$ kubectl create serviceaccount --namespace kube-system tiller
$ kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
```

### ~~初始化 helm~~（在 helm3 中已废弃）

```bash
$ helm init 
```

### ~~为 tiller 设置 serviceAccount~~（在 helm3 中已废弃）

```bash
$ kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
```

### 查看 helm 的版本

```bash
$ helm version

version.BuildInfo{Version:"v3.1.1", GitCommit:"afe70585407b420d0097d07b21c47dc511525ac8", GitTreeState:"clean", GoVersion:"go1.13.8"}
```

### 简单使用

```bash
# 列出所有仓库
$ helm repo list

# 添加一个仓库
$ helm repo add google https://kubernetes-charts.storage.googleapis.com

# 更新仓库
$ helm repo update

# 安装一个 chart (以 drone 为例)
$ helm install stable/drone
```