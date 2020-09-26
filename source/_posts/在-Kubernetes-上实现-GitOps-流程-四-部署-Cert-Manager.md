---
title: 在 Kubernetes-EKS 上实现 GitOps 流程(四) - 部署 Cert Manager
date: 2020-09-25 10:39:25
tags:
- AWS EKS
- Kubernetes
- GitOps
---

在之前的文章 [使用 Cert Manager 为 Kubernetes 应用自动签发 HTTPS 证书](/post/使用-Cert-Manager-为-Kubernetes-应用自动签发-HTTPS-证书) 中, 介绍了使用 helm 部署 Cert Manager, 这次介绍使用 GitOps 的方式来部署 Cert Manager

### 部署

由于 Cert Manager 自身的原因, Cert Manager 只能部署在 `cert-manager` 命名空间下, 否则会报 `webhook not found` 之类的错误

新建命名空间 `nameaspces/cert-manager.yaml`:

```yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: cert-manager
```

新建在 Let's Encrypt `prod` 和 `staging` 环境下的 `cluster issuer`:

`/crds/cert-manager/cluster-issuer-prod.yaml`:

```yaml
apiVersion: cert-manager.io/v1alpha2
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    email: #<替换为你自己的邮箱, 用于接收 Let's Encrypt 的通知>
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
      - http01:
          ingress:
            class: nginx
```

`/crds/cert-manager/cluster-issuer-staging.yaml`:

```yaml
apiVersion: cert-manager.io/v1alpha2
kind: ClusterIssuer
metadata:
  name: letsencrypt-staging
spec:
  acme:
    email: #<替换为你自己的邮箱, 用于接收 Let's Encrypt 的通知>
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt-staging
    solvers:
      - http01:
          ingress:
            class: nginx
```

新建 hr `releases/cert-manager/helmrelease.yaml`:

```yaml
---
apiVersion: helm.fluxcd.io/v1
kind: HelmRelease
metadata:
  name: cert-manager
  namespace: cert-manager
  annotations:
    fluxcd.io/automated: "false"
spec:
  releaseName: cert-manager
  chart:
    repository: https://charts.jetstack.io
    name: cert-manager
    version: "v1.0.2"
  values:
    installCRDs: true
```

之后提交 commit 并推送到远程仓库, 稍微等待下后, 查看 Cert Manager:

```bash
$ kubectl get pods -n cert-manager

NAME                                       READY   STATUS    RESTARTS   AGE
cert-manager-7ddc5b4db-g52tz               1/1     Running   0          18s
cert-manager-cainjector-6644dc4975-2bxr2   1/1     Running   1          18s
cert-manager-webhook-7b887475fb-wqjgk      1/1     Running   0          18s
```

可以看到 Cert Manager 已经成功部署了

