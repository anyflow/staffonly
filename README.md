# Staffonly


```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kic-st-staffonly
spec:
  project: cluster
  source:
    repoURL: ssh://git@gitea.thinq.link:2222/cluster/staffonly.git
    path: deployment
    targetRevision: main
  destination:
    namespace: ns-cluster
    name: kic-st-cluster
```