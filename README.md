# es-helper
[![GitHub release](https://img.shields.io/github/release/BESTSELLER/es-helper.svg)](https://github.com/BESTSELLER/es-helper/releases/)
[![CircleCI](https://circleci.com/gh/BESTSELLER/es-helper.svg?style=svg)](https://circleci.com/gh/BESTSELLER/es-helper)

A collection of tools for your kubernetes definitions. It will validate your YAML ( or JSON ), check for deprecated APIs and perform static code analysis of your Kubernetes object definitions.

Available as:

Image which can found at [harbor.bestsellerit.com/library/es-helper](https://harbor.bestsellerit.com/library/es-helper)

CircleCI Orb which can found [here](https://circleci.com/orbs/registry/orb/bestsellerit/es-helper)

## What is included

- kubeval (https://github.com/instrumenta/kubeval)
- conftest (https://github.com/instrumenta/conftest)
- kube-score (https://github.com/zegl/kube-score)

## How to
The helper is available either as CircleCI Orb or as a plain docker image that can be included in your CI of choice.

### Docker image
Pull the image and run each of the commands.
Default entrypoint is `sh`.

```sh
docker run -it -v path/to/config:/path/to/config harbor.bestsellerit.com/library/es-helper:latest sh

# run a sample command in the container
conftest test /path/to/config -p /policies/1.16
```

or run everyting as one commmand
```sh
docker run -v path/to/config:/path/to/config harbor.bestsellerit.com/library/es-helper:latest /bin/bash -c "conftest test /path/to/config -p /policies/<kubernetes_version> && kubeval /path/to/config --strict --kubernetes-version <kubernetes_version>.0 && kube-score score /path/to/config"
```

### CircleCI Orb
es-helper can be both as a job in your workflow or as a step in an existing job

### Seperate job
Running it as part of your CircleCI pipeline is simple as:
```yaml
version: 2.1

orbs:
  es-helper: bestsellerit/es-helper@0.0.1

workflows:
  build:
    jobs:
      - es-helper/check-kube-config:
          path: ./deployment.yaml ingress.yaml
          kubernetes_version: "1.16" 
          #kubernetes_version: "$K8S_VERSION" # We use this in BESTSELLER, as we have our versions in our contexts.
```
*When running the helper as an orb the kube-score command will always exit succesfuly even if criticals occur.*

### As a step in your existing job
```yaml
version: 2.1

orbs:
  es-helper: bestsellerit/es-helper@0.0.1

jobs:
  build:
    description: Build Job
    executor: someimage
    steps:
      - checkout
      - es-helper/check-kube-config:
          path: ./deployment.yaml ingress.yaml
          kubernetes_version: "1.16"
          #kubernetes_version: "$K8S_VERSION" # We use this in BESTSELLER, as we have our versions in our contexts.
      - run:
          name: some command
          command: which some
```

### Orb versions
`CircleCI` orbs are published with the standard 3-number semantic versioning system.
You an either choose one of our specific versions eg. `0.0.17` or choose to always download the newest version by adding `volatile` as version.

More info [here](https://circleci.com/docs/2.0/using-orbs/#semantic-versioning-in-orbs)



## Contributing?
Do you want to help out? Issues and pull requests are more than welcome. :D