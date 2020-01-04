---
title: Win10 下使用 Minikube 部署本地 k8s 节点
date: 2020-01-04 16:35:46
tags:
- docker
- k8s
- minikube
category: DevOps
---

## 开启 Kubernetes

**先决条件**，你需要一个 Docker for Mac或者Docker for Windows的安装包，如果没有请下载[下载 Docker CE最新版本](https://yq.aliyun.com/go/articleRenderRedirect?url=https%3A%2F%2Fstore.docker.com%2Fsearch%3Ftype%3Dedition%26amp%3Boffering%3Dcommunity)。由于Kubernetes大量的容器镜像在 gcr.io， 无法在国内保证稳定的访问。我们提供了一些[工具脚本](https://yq.aliyun.com/go/articleRenderRedirect?url=https%3A%2F%2Fgithub.com%2FAliyunContainerService%2Fk8s-for-docker-desktop)，帮助从阿里云镜像服务下载所需镜像

首先，

```
git clone https://github.com/AliyunContainerService/k8s-for-docker-desktop
cd k8s-for-docker-desktop
```

**注意选择根据本机上的 Docker 和 k8s 版本选择对应分支!**

### Docker for Mac 开启 Kubernetes

为 Docker daemon 配置 Docker Hub 的中国官方镜像加速 `https://registry.docker-cn.com`

![mirror](https://yqfile.alicdn.com/979d0e121d6f9929a6d117f277003ac83664718c.png)

可选操作: 为 Kubernetes 配置 CPU 和 内存资源，建议分配 4GB 或更多内存。

![resource](https://yqfile.alicdn.com/61ae11ebd5b54db875390a1f2a5f36c6a4a32154.png)

预先从阿里云Docker镜像服务下载 Kubernetes 所需要的镜像, 可以通过修改 `images.properties` 文件加载你自己需要的镜像

```
./load_images.sh
```

开启 Kubernetes，并等待 Kubernetes 开始运行

![k8s](https://yqfile.alicdn.com/c54a96b9309adb38687f9e0678bbc207a3634cb2.png)

### Docker for Windows 开启 Kubernetes

为 Docker daemon 配置 Docker Hub 的中国官方镜像加速 `https://registry.docker-cn.com`

![mirror_win](https://yqfile.alicdn.com/bc03181b01d378ae32145614ada40872810290e6.png)

可选操作: 为 Kubernetes 配置 CPU 和 内存资源，建议分配 4GB 或更多内存。

![resource_win](https://yqfile.alicdn.com/17f7c7923fa86fbf1600e717973975970ce49af0.png)

预先从阿里云Docker镜像服务下载 Kubernetes 所需要的镜像, 可以通过修改 `images.properties` 文件加载你自己需要的镜像

使用 Bash shell

```
./load_images.sh
```

使用 PowerShell

```
 .\load_images.ps1
```

说明: 如果因为安全策略无法执行 PowerShell 脚本，请在 “以管理员身份运行” 的 PowerShell 中执行 `Set-ExecutionPolicy RemoteSigned` 命令。

开启 Kubernetes，并等待 Kubernetes 开始运行

![k8s_win](https://yqfile.alicdn.com/047e1311a6625257ca909ef6cf2525518d9a1aec.png)

## 安装 Minikube

在 [Minikube](https://minikube.sigs.k8s.io/docs/start/) 官网选择对应版本并安装

完成后在 Powershell（管理员）中执行以下命令启动虚拟机

```bash
$ minikube start --image-mirror-country cn --iso-url=https://kubernetes.oss-cn-hangzhou.aliyuncs.com/minikube/iso/minikube-v1.6.0.iso --registry-mirror=https://xxxxxx.mirror.aliyuncs.com

* Microsoft Windows 10 Pro 10.0.18362 Build 18362 上的 minikube v1.6.2
* Selecting 'hyperv' driver from user configuration (alternates: [])
! 您所在位置的已知存储库都无法访问。正在将 registry.cn-hangzhou.aliyuncs.com/google_containers 用作后备存储库。
* Tip: Use 'minikube start -p <name>' to create a new cluster, or 'minikube delete' to delete this one.
* Using the running hyperv "minikube" VM ...
* Waiting for the host to be provisioned ...
PS C:\WINDOWS\system32> ^C
PS C:\WINDOWS\system32> kubectl get nodes
Error in configuration:
* unable to read client-cert C:\Users\firmoo\.minikube\client.crt for minikube due to open C:\Users\firmoo\.minikube\client.crt: The system cannot find the file specified.
* unable to read client-key C:\Users\firmoo\.minikube\client.key for minikube due to open C:\Users\firmoo\.minikube\client.key: The system cannot find the file specified.
* unable to read certificate-authority C:\Users\firmoo\.minikube\ca.crt for minikube due to open C:\Users\firmoo\.minikube\ca.crt: The system cannot find the file specified.
PS C:\WINDOWS\system32> minikube start --image-mirror-country cn --iso-url=https://kubernetes.oss-cn-hangzhou.aliyuncs.com/minikube/iso/minikube-v1.6.0.iso --registry-mirror=https://xxxxxx.mirror.aliyuncs.com
* Microsoft Windows 10 Pro 10.0.18362 Build 18362 上的 minikube v1.6.2
* Selecting 'hyperv' driver from user configuration (alternates: [])
! 您所在位置的已知存储库都无法访问。正在将 registry.cn-hangzhou.aliyuncs.com/google_containers 用作后备存储库。
* Tip: Use 'minikube start -p <name>' to create a new cluster, or 'minikube delete' to delete this one.
* Using the running hyperv "minikube" VM ...
* Waiting for the host to be provisioned ...
! VM is unable to access k8s.gcr.io, you may need to configure a proxy or set --image-repository
* 正在 Docker '19.03.5' 中准备 Kubernetes v1.17.0…
* 正在下载 kubeadm v1.17.0
* 正在下载 kubelet v1.17.0
* 正在启动 Kubernetes ...
* 完成！kubectl 已经配置至 "minikube"
! C:\Program Files\Docker\Docker\Resources\bin\kubectl.exe is version 1.14.8, and is incompatible with Kubernetes 1.17.0. You will need to update C:\Program Files\Docker\Docker\Resources\bin\kubectl.exe or use 'minikube kubectl' to connect with this cluster
```

获取 k8s 节点

```bash
$ kubectl get nodes

NAME       STATUS   ROLES    AGE   VERSION
minikube   Ready    master   65s   v1.17.0
```

访问控制面板

```bash
$ minikube dashboard

* Verifying dashboard health ...
* Launching proxy ...
* Verifying proxy health ...
* Opening http://127.0.0.1:51733/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/ in your default browser...
```