---
title: 使用 Cert Manager 为 Kubernetes 应用自动签发 HTTPS 证书
date: 2020-03-27 13:44:55
tags:
- Kubernetes
- Helm
- Cert Manager
- Let’s Encrypt
thumbnail: https://s1.ax1x.com/2020/03/28/GkNpan.jpg
---

>  Cert-Manager 是一个云原生证书管理开源项目，用于在 Kubernetes 集群中提供 HTTPS 证书并自动续期，支持 Let’s Encrypt / HashiCorp / Vault 这些免费证书的签发。在 Kubernetes 中，可以通过 Kubernetes Ingress 和 Let’s Encrypt 实现外部服务的自动化 HTTPS

<!-- more -->

此文章按照 [Cert Manager 官网](https://cert-manager.io/docs/installation/kubernetes/) 的推荐步骤, 使用 helm3 安装并配置 Cert-Manager

### 安装 Helm3

若你还未安装 Helm3, 可参考我的 [这篇文章](/post/在-Kubernets-上安装-Helm) 安装 Helm

### 安装 Cert-Manager 

#### 创建 `CustomResourceDefinition` 用户自定义资源

```bash
# 针对 Kubernetes 1.15+ 以上版本使用以下命令
$ kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.14.0/cert-manager.crds.yaml

customresourcedefinition.apiextensions.k8s.io/certificaterequests.cert-manager.io created
customresourcedefinition.apiextensions.k8s.io/certificates.cert-manager.io created
customresourcedefinition.apiextensions.k8s.io/challenges.acme.cert-manager.io created
customresourcedefinition.apiextensions.k8s.io/clusterissuers.cert-manager.io created
customresourcedefinition.apiextensions.k8s.io/issuers.cert-manager.io created
customresourcedefinition.apiextensions.k8s.io/orders.acme.cert-manager.io created
```

#### 创建命名空间

我使用的命名空间为 `cluster-service`，替换为你自己的命名空间：

```bash
$ kubectl create namespace cluster-service

namespace/cluster-service created
```

#### 添加 `Jetstack` Helm 仓库

```bash
$ helm repo add jetstack https://charts.jetstack.io
```

#### 更新 Helm 仓库

```bash
$ helm repo update
```

#### 安装 Cert Manager

```bash
# Helm v3+
$ helm install \
  cert-manager jetstack/cert-manager \
  --namespace cluster-service \
  --version v0.14.0
  

NAME: cert-manager
LAST DEPLOYED: Fri Mar 27 06:26:00 2020
NAMESPACE: cluster-service
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
cert-manager has been deployed successfully!

In order to begin issuing certificates, you will need to set up a ClusterIssuer
or Issuer resource (for example, by creating a 'letsencrypt-staging' issuer).

More information on the different types of issuers and how to configure them
can be found in our documentation:

https://docs.cert-manager.io/en/latest/reference/issuers.html

For information on how to configure cert-manager to automatically provision
Certificates for Ingress resources, take a look at the `ingress-shim`
documentation:

https://docs.cert-manager.io/en/latest/reference/ingress-shim.html
```

#### 安装成功, 查看安装结果

我使用的 Kubernetes 管理界面是 [Kuboard](http://kuboard.cn)

![1585290595100](https://s1.ax1x.com/2020/03/28/GkJ4zD.png)

#### 配置 Issuer 或 Clusterissuer

> 官方介绍这中 Issuer 与 ClusterIssuer 的概念：
>
> `Issuers`, and `ClusterIssuers`, are Kubernetes resources that represent certificate authorities (CAs) that are able to generate signed certificates by honoring certificate signing requests. All cert-manager certificates require a referenced issuer that is in a ready condition to attempt to honor the request.

Issuer 与 ClusterIssuer 的区别是 ClusterIssuer 可跨命名空间使用，而 Issuer 需在每个命名空间下配置后才可使用。我在此使用ClusterIssuer，其类型选择 Let‘s Encrypt

配置 `staging` 环境使用的 Let‘s Encrypt ClusterIssuer，并创建：

```yaml
# cluster-issuer-letsencrypt-staging.yaml

apiVersion: cert-manager.io/v1alpha2
kind: ClusterIssuer
metadata:
  name: letsencrypt-staging
spec:
  acme:
    # 务必将此处替换为你自己的邮箱, 否则会配置失败。当证书快过期时 Let's Encrypt 会与你联系
    email: user@example.com
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      # 将用来存储 Private Key 的 Secret 资源
      name: letsencrypt-staging
    # Add a single challenge solver, HTTP01 using nginx
    solvers:
    - http01:
        ingress:
          class: nginx
```

```bash
$ kubectl create -f cluster-issuer-letsencrypt-staging.yaml

clusterissuer.cert-manager.io/letsencrypt-staging created
```

配置 `production` 环境使用的  Let‘s Encrypt ClusterIssuer，并创建：

```yaml
# cluster-issuer-letsencrypt-prod.yaml

apiVersion: cert-manager.io/v1alpha2
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: varroreve@gmail.com
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
      - http01:
          ingress:
            class: nginx
```

```
$ kubectl create -f cluster-issuer-letsencrypt-prod.yaml

clusterissuer.cert-manager.io/letsencrypt-prod created
```

查看：

```bash
$ kubectl get clusterissuer

NAME                  READY   AGE
letsencrypt-prod      True    37s
letsencrypt-staging   True    119m
```

这里分别配置了测试环境与生产环境两个 ClusterIssuer， 原因是 Let’s Encrypt 的生产环境有着非常严格的接口调用限制，最好是在测试环境测试通过后，再切换为生产环境。 

> [Let’s Encrypt 测试环境与生产环境的区别](https://letsencrypt.org/zh-cn/docs/staging-environment/)

### 测试

这里我假设你已安装好 Nginx Ingress Controller 并已存在一个 Ingress 对象，现在为它开启 TLS 选项

```yaml
# quickstart-example.yaml

apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: kuard
  annotations:
    # 务必添加以下两个注解, 指定 ingress 类型及使用哪个 cluster-issuer
    kubernetes.io/ingress.class: "nginx"
    cert-manager.io/cluster-issuer："letsencrypt-staging"
    
    # 如果你使用 issuer, 使用以下注解 
    # cert-manager.io/issuer: "letsencrypt-staging"

spec:
  tls:
  - hosts:
    - example.example.com                # TLS 域名
    secretName: quickstart-example-tls   # 用于存储证书的 Secret 对象名字 
  rules:
  - host: example.example.com
    http:
      paths:
      - path: /
        backend:
          serviceName: kuard
          servicePort: 80
```

应用此更新

```bash
$ kubectl create -f quickstart-example.yaml
```

之后 Cert-manager 会读取注解并创建证书，使用以下命令查看：

```bash
$ kubectl get certificate -A

NAME                     READY   SECRET                   AGE
quickstart-example-tls   True    quickstart-example-tls   16m
```

当 Ready 为 True 时代表证书安装成功若出现问题可使用 `descirbe` 命令查看具体出错原因：

```bash
$ kubectl describe certificate -A 
```

### 切换到生产环境

当一切就绪后，将 Ingress 对象中的 `cluster-issuer` 注解改为 Let's Encrypt 生产环境

```yaml
# quickstart-example.yaml

cert-manager.io/cluster-issuer: "letsencrypt-prod"
```

更新 Ingress 后访问你的网站，应该可以看到 HTTPS 证书配置

![1585373007182](https://s1.ax1x.com/2020/03/28/GkJfJK.png)

![1585373024926](https://s1.ax1x.com/2020/03/28/GkJhRO.png)