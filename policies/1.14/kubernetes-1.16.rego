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

# All resources under apps/v1beta1 and apps/v1beta2 - use apps/v1 instead
_warn = msg {
  apis := ["apps/v1beta1", "apps/v1beta2"]
  input.apiVersion == apis[_]
  msg := sprintf("%s/%s: API %s will be deprecated in 1.16, use apps/v1 instead.", [input.kind, input.metadata.name, input.apiVersion])
}

# daemonsets, deployments, replicasets resources under extensions/v1beta1 - use apps/v1 instead
_warn = msg {
  resources := ["DaemonSet", "Deployment", "ReplicaSet"]
  input.apiVersion == "extensions/v1beta1"
  input.kind == resources[_]
  msg := sprintf("%s/%s: API extensions/v1beta1 for %s will be deprecated in 1.16, use apps/v1 instead.", [input.kind, input.metadata.name, input.kind])
}

# networkpolicies resources under extensions/v1beta1 - use networking.k8s.io/v1 instead
_warn = msg {
  input.apiVersion == "extensions/v1beta1"
  input.kind == "NetworkPolicy"
  msg := sprintf("%s/%s: API extensions/v1beta1 for NetworkPolicy will be deprecated in 1.16, use networking.k8s.io/v1 instead.", [input.kind, input.metadata.name])
}

# podsecuritypolicies resources under extensions/v1beta1 - use policy/v1beta1 instead
_warn = msg {
  input.apiVersion == "extensions/v1beta1"
  input.kind == "PodSecurityPolicy"
  msg := sprintf("%s/%s: API extensions/v1beta1 for PodSecurityPolicy will be deprecated in 1.16, use policy/v1beta1 instead.", [input.kind, input.metadata.name])
}

# PriorityClass resources will no longer be served from scheduling.k8s.io/v1beta1 and scheduling.k8s.io/v1alpha1 in v1.17.
_warn = msg {
  apis := ["scheduling.k8s.io/v1beta1", "scheduling.k8s.io/v1alpha1"]
  input.apiVersion == apis[_]
  input.kind == "PriorityClass"
  msg := sprintf("%s/%s: API %s for PriorityClass will be deprecated in 1.16, use scheduling.k8s.io/v1 instead.", [input.kind, input.metadata.name, input.apiVersion])
}