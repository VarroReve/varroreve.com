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

```bash
$ curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
$ chmod 700 get_helm.sh
$ ./get_helm.sh
```

### 赋予 tiller 权限

```bash
$ kubectl create serviceaccount --namespace kube-system tiller
$ kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
```

### 初始化 helm

```bash
$ helm init 
```

### 为 tiller 设置 serviceAccount

```bash
$ kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
```

### 查看 helm 与 tiller 的版本

```bash
$ helm version

Client: &version.Version{SemVer:"v2.16.3", GitCommit:"1ee0254c86d4ed6887327dabed7aa7da29d7eb0d", GitTreeState:"clean"}
Server: &version.Version{SemVer:"v2.16.3", GitCommit:"1ee0254c86d4ed6887327dabed7aa7da29d7eb0d", GitTreeState:"clean"}
```

```bash
$ kubectl get pod -n kube-system |grep tiller

tiller-deploy-5b4685ffbf-pq9l8             1/1     Running   0          37m
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