---
title: '在 Kubernetes 上实现 GitOps 流程: 环境搭建(二)'
date: 2020-09-22 10:57:55
tags:
- AWS EKS
- Kubernetes
- GitOps
---

## 工具准备

### 准备 AWS 账户

开通一个 AWS 账户, 并具有 EKS 相关权限 (具体需要的权限自行解决, 太多了写不完)

在 AWS 控制台中, 点击 `我的安全凭证 -> 创建访问秘钥`, 会得到访问秘钥文件, 保存好以备后用

<!-- more -->

### 安装 awscli

根据 awscli [官方文档](https://aws.amazon.com/cli/), 选择对应系统的版本并安装

安装后运行命令行, 运行 `aws configure` 并按照提示输入上一步得到的秘钥完成配置

```bash
$ aws --version

aws-cli/1.18.35 Python/3.6.0 Windows/10 botocore/1.15.35
```

### 安装 eksctl

根据 eksctl 的[文档](https://eksctl.io/introduction/#installation), 选择对应系统的版本并安装 (ps: Windows 下需先安装 [chocolate](https://chocolatey.org/))

查看 eksctl 版本:

```bash
$ eksctl version

0.25.0
```

### 安装 kubectl

根据 kubectl 的[文档](https://kubernetes.io/docs/tasks/tools/install-kubectl/), 选择对应系统的版本并安装

查看 kubectl 版本:

```bash
$ kubectl version --client

Client Version: version.Info{Major:"1", Minor:"17", GitVersion:"v1.17.0", GitCommit:"70132b0f130acc0bed193d9ba59dd186f0e634cf", GitTreeState:"clean", BuildDate:"2019-12-07T21:20:10Z", GoVersion:"go1.13.4", Compiler:"gc", Platform:"windows/amd64"}
```

### 安装 helm

根据 helm 的[文档](https://helm.sh/docs/intro/install/), 选择对应系统的版本并安装 (ps: Windows 下需先安装 [chocolate](https://chocolatey.org/))

查看 helm 版本:

```bash
$ helm version

version.BuildInfo{Version:"v3.2.4", GitCommit:"0ad800ef43d3b826f31a5ad8dfbb4fe05d143688", GitTreeState:"clean", GoVersion:"go1.13.12"}
```

### 安装 fluxctl

根据 fluxctl 的[文档](https://docs.fluxcd.io/en/latest/references/fluxctl/), 选择对应系统的版本并安装 (ps: Windows 下需先安装 [chocolate](https://chocolatey.org/))

查看 fluxctl 版本:

```bash
$ fluxctl version

1.19.0
```

### 创建 GitOps 的配置仓库

GitOps 的核心组件 FluxCD 需要一个 Git 仓库作为配置仓库, 在 GitHub / GItLab 或其他平台新建一个仓库, 共有或私有均可

本文章使用的配置仓库地址为: https://github.com/VarroReve/EKS-GitOps

## 部署集群

### 使用 eksctl 新建 EKS 集群

通过以下命令新建集群

```bash
$ eksctl create cluster \
--name gitops \
--region ap-east-1 \
--nodegroup-name gitops-workers \
--node-type t3.medium \
--nodes 2 \
--nodes-min 1 \
--nodes-max 2 \
--managed \
--alb-ingress-access
```

参数释义:

- name: EKS 集群名称, 替换为你自己的集群名称
- region: AWS 区域, 我使用的是香港区域 ap-east-1 
- nodegroup-name: 节点组名称,  替换为你自己的节点组名称
- node-type: 节点 EC2 实例类型, 我使用的是 t3.medium
- nodes: 节点期望数量
- nodes-min: 节点最低数量
- nodes-max: 节点最大数量
- managed: 创建由 EKS 完全管理的节点组
- alb-ingress-access: 启用 AWS ALB(应用负载均衡器) 完全访问

### 更新 kubeconfig

EKS 创建后会自动更新 `~/.kube/config` 配置文件, 你也可以执行以下命令手动更新 `kubectl` 配置:

```bash
$ aws eks --region ap-east-1 update-kubeconfig --name gitops
```

查看集群状况

```bash
$ kubectl get svc

NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.100.0.1   <none>        443/TCP   18m
```

### 为集群启用 GitOps

eksctl 提供了快捷的方式来安装 flux 与 helm:

```bash
$ eksctl enable repo \
--cluster=gitops \
--region=ap-east-1 \
--git-url=git@github.com:VarroReve/EKS-GitOps.git \
--namespace=gitops \
--git-email=flux@firmooinc.com \
--with-helm
```

安装完成后, 查看 flux 与 helm:

```bash
$ kubectl get pod -n gitops

NAME                             READY   STATUS    RESTARTS   AGE
flux-ffc78f966-2gnpj             1/1     Running   0          41s
helm-operator-6fd6b7fbfc-xgcrf   1/1     Running   0          41s
memcached-7dd5ff9dcf-rcpkg       1/1     Running   0          42s
```

获取 fluxcd 所使用的 ssh 秘钥:

```bash
$ fluxctl identity --k8s-fwd-ns gitops

ssh-rsa XXXXXXXXXXXXXXXXXXXXXXXXXXX= root@XXXXXXXXXXXXXXXXXXX
```

打开你的配置仓库设置, 将以上输出的 ssh 公钥加入仓库的 deploy keys 中, **并确保给与写入仓库的权限**

## 体验 GitOps

以上步骤完成后, EKS + Git + Helm + FluxCD 的 GitOps 已大体完成, 但还缺少一个 CI 工具, 本文之后会以 GitOps 的方式部署 Drone CI, 但是在此前先体验下 GitOps 的工作方式

### 克隆配置仓库到本地

```bash
$ git clone git@github.com:VarroReve/EKS-GitOps.git
```

此时仓库还是一个没有任何文件的空仓库

### 新建 Kubernetes 的命名空间

在配置仓库根目录下创建 `namespaces` 目录, 并在该目录下创建 `staging.yaml` 文件, 该文件用来创建一个名为 `staging` 的命名空间

```yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: staging
```

提交并推送到远程仓库, 此时查看命名空间, 发现 `staging` 命名空间已经被创建

```bash
$ kubectl get ns

NAME              STATUS   AGE
default           Active   102m
gitops            Active   68m
kube-node-lease   Active   102m
kube-public       Active   102m
kube-system       Active   102m
staging           Active   61s
```

这是因为 FluxCD 会持续监视配置仓库的文件改动, 一但发现有 .yaml 文件的改动, 就会将该 .yaml 部署到集群中

这也就是 GitOps 的核心理念: 通过使用 Git 作为唯一的事实来源，去声明基础架构以及应用负载所期望达到的最终运行状态

意思就是说, 我们应尽量避免通过 kubectl 或其他形式直接操作集群, 而是应将改动通过 git 提交到代码仓库, 由持续交付引擎来为我们部署改动. 这样就可做到对集群的改动可审计, 也方便集群的移植/复制

我以同样的方式又新建了三个命名空间, 以备后用

最终的配置仓库目录结构如下:

```
│  .gitignore
└─namespaces
        gitops.yaml
        prod.yaml
        staging.yaml
        test.yaml
```

命名空间如下:

```bash
$ kubectl get ns

NAME              STATUS   AGE
default           Active   116m
gitops            Active   82m
kube-node-lease   Active   116m
kube-public       Active   116m
kube-system       Active   116m
prod              Active   8s
staging           Active   15m
test              Active   8s
```

PS: 如果你将配置推送到仓库后, 发现没有新的命名空间出现, 那么可以使用 `fluxctl sync --k8s-fwd-ns gitops` 手动同步最新配置到集群, 这是因为 flux 的机制是定期轮询配置仓库, 所以有时候新改动不会立刻生效 

## 部署 Ingress Controller

EKS 天然支持 AWS Application Load Balancer (ALB), 但是 [ALB Ingress Controller](https://github.com/kubernetes-sigs/aws-alb-ingress-controller) 有个问题, 就是多个 Service 不能复用同一个 alb, 这就导致如果预发/测试环境中有很多项目, 就需要创建很多 alb, 成本较高. ALB Ingress Controller的开发组也正在解决这个问题, 详见 [Ingress Group Feature Testing #914 ](https://github.com/kubernetes-sigs/aws-alb-ingress-controller/issues/914)

基于以上原因, 所以我选择使用 [Nginx Ingress Controller](https://kubernetes.github.io/ingress-nginx/), 好消息是使用 Nginx Ingress Controller 创建 Service 时会自动创建 AWS Classic Load Balancer (CLB), 并且多个 Service 可以服用一个 CLB

## 部署 Drone CI

