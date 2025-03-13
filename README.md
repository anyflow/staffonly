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

- Kubernetes에 `./deployment`의 manifest 설치(Kustomize)
- `> kubectl exec -it <staffonly pod 이름> -- zsh` (`Makefile`의 `run_in_k8s` 참고)

## ArgoCD application manifest example

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: staffonly
spec:
  project: staffonly
  source:
    repoURL: git@github.com:anyflow/staffonly.git
    path: deployment
    targetRevision: main
  destination:
    namespace: service
    name: cluster
```