#!/usr/bin/env bash

set -uo errexit

KUBEVAL=0.15.0
printf "\ndownloading kubeval ${KUBEVAL}\n"
curl -sL https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL}/kubeval-linux-amd64.tar.gz | \
tar xz && mv kubeval /usr/local/bin/kubeval
kubeval --version

CONFTEST=0.19.0
printf "\ndownloading conftest ${CONFTEST}\n"
curl -sL https://github.com/instrumenta/conftest/releases/download/v${CONFTEST}/conftest_${CONFTEST}_Linux_x86_64.tar.gz | \
tar xz && mv conftest /usr/local/bin/conftest
conftest --version

printf "\nfetch kubeval kubernetes json schemas\n"
mkdir -p /usr/local/kubeval/schemas && \
curl https://codeload.github.com/instrumenta/kubernetes-json-schema/tar.gz/master | \
tar -C /usr/local/kubeval/schemas --strip-components=1 -xzf - \
kubernetes-json-schema-master/v1.14.0-standalone-strict \
kubernetes-json-schema-master/v1.15.0-standalone-strict \
kubernetes-json-schema-master/v1.16.0-standalone-strict

printf "\nfetch conftest kubernetes policies\n"
wget -O - https://github.com/swade1987/deprek8ion/archive/master.tar.gz | tar -xz --strip=1 "deprek8ion-master/policies" -C /policies

printf "\downloading kube-score\n"
curl -sL https://github.com/zegl/kube-score/releases/download/v1.7.1/kube-score_1.7.1_linux_amd64.tar.gz | \
tar xz && mv kube-score /usr/local/bin/kube-score
kube-score version