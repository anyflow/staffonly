# Staffonly

## Introduction

Kubernetes, Istio 운영자를 위한 image이다.

## Features

- **`nicolaka/netshoot`**
  - 각종 networking trouble shooting을 위한 도구 모음으로 base image로 사용
  - https://github.com/nicolaka/netshoot 참조
- **`kubectl`**
  - `kubectl` 및 kubectl completion, `k` alias 지원
- **`istioctl`**
  - `istioctl` 및 istioctl completion, `i` alias 지원
- **`k9s`**
  - https://k9scli.io/ 참조

## 사용 방법

1. Kubernets에 `./deployment`의 manifest 설치(Kustomize)
- `kubectl exec -it staffonly -- zsh` 명령을 통해 접근

  > 주의: sh로 접근을 하였다 하더라도 `zsh` shell을 사용해야 모든 feature를 문제없이 사용 가능


## ArgoCD application manifest example

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kic-st-staffonly
spec:
  project: staffonly
  source:
    repoURL: ssh://git@gitea.thinq.link:2222/cluster/staffonly.git
    path: deployment
    targetRevision: main
  destination:
    namespace: ns-cluster
    name: kic-st-cluster
```