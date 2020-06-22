package main

warn[msg] {
  input.apiVersion == "v1"
  input.kind == "List"
  obj := input.items[_]
  msg := _warn with input as obj
}

warn[msg] {
  input.apiVersion != "v1"
  input.kind != "List"
  msg := _warn
}

# Based on https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.16.md
# Based on https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.19.md

# The apiregistration.k8s.io/v1beta1 version is deprecated in 1.19. Migrate to use apiregistration.k8s.io/v1 instead
_warn = msg {
  input.apiVersion == "apiregistration.k8s.io/v1beta1"
  msg := sprintf("%s/%s: API apiregistration.k8s.io/v1beta1 is deprecated in Kubernetes 1.19, use apiregistration.k8s.io/v1 instead.", [input.kind, input.metadata.name])
}

# The authentication.k8s.io/v1beta1 version is deprecated in 1.19. Migrate to use authentication.k8s.io/v1 instead
_warn = msg {
  input.apiVersion == "authentication.k8s.io/v1beta1"
  msg := sprintf("%s/%s: API authentication.k8s.io/v1beta1 is deprecated in Kubernetes 1.19, use authentication.k8s.io/v1 instead.", [input.kind, input.metadata.name])
}

# The authorization.k8s.io/v1beta1 version is deprecated in 1.19. Migrate to use authorization.k8s.io/v1 instead
_warn = msg {
  input.apiVersion == "authorization.k8s.io/v1beta1"
  msg := sprintf("%s/%s: API authorization.k8s.io/v1beta1 is deprecated in Kubernetes 1.19, use authorization.k8s.io/v1 instead.", [input.kind, input.metadata.name])
}

# The coordination.k8s.io/v1beta1 version is deprecated in 1.19. Migrate to use coordination.k8s.io/v1 instead
_warn = msg {
  input.apiVersion == "coordination.k8s.io/v1beta1"
  msg := sprintf("%s/%s: API coordination.k8s.io/v1beta1 is deprecated in Kubernetes 1.19, use coordination.k8s.io/v1 instead.", [input.kind, input.metadata.name])
}

# The storage.k8s.io/v1beta1 version is deprecated in 1.19. Migrate to use storage.k8s.io/v1 instead
_warn = msg {
  input.apiVersion == "storage.k8s.io/v1beta1"
  msg := sprintf("%s/%s: API storage.k8s.io/v1beta1 is deprecated in Kubernetes 1.19, use storage.k8s.io/v1 instead.", [input.kind, input.metadata.name])
}
