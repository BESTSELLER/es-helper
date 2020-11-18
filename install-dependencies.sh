#!/usr/bin/env bash

set -uo errexit

KUBEVAL=0.15.0
printf "\ndownloading kubeval ${KUBEVAL}\n"
curl -sL https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL}/kubeval-linux-amd64.tar.gz | \
tar xz && mv kubeval /usr/local/bin/kubeval
kubeval --version

CONFTEST=0.22.0
printf "\ndownloading conftest ${CONFTEST}\n"
curl -sL https://github.com/instrumenta/conftest/releases/download/v${CONFTEST}/conftest_${CONFTEST}_Linux_x86_64.tar.gz | \
tar xz && mv conftest /usr/local/bin/conftest
conftest --version

KUBESCORE=1.10.0
printf "\ndownloading kube-score ${KUBESCORE}\n"
curl -sL https://github.com/zegl/kube-score/releases/download/v${KUBESCORE}/kube-score_${KUBESCORE}_linux_amd64.tar.gz | \
tar xz && mv kube-score /usr/local/bin/kube-score
kube-score version