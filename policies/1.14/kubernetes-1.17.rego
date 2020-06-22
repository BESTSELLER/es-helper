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

# PriorityClass resources will no longer be served from scheduling.k8s.io/v1beta1 and scheduling.k8s.io/v1alpha1 in v1.17.
_warn = msg {
  apis := ["scheduling.k8s.io/v1beta1", "scheduling.k8s.io/v1alpha1"]
  input.apiVersion == apis[_]
  input.kind == "PriorityClass"
  msg := sprintf("%s/%s: API %s for PriorityClass will be deprecated in 1.17, use scheduling.k8s.io/v1 instead.", [input.kind, input.metadata.name, input.apiVersion])
}