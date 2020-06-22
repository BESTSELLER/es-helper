# es-helper
[![CircleCI](https://circleci.com/gh/BESTSELLER/es-helper.svg?style=svg)](https://circleci.com/gh/BESTSELLER/es-helper)

A collection of tools for checking your kubernetes specs.

Available as:

Image which can found at [harbor.bestsellerit.com/library/es-helper](harbor.bestsellerit.com/library/es-helper)

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


### CircleCI Orb
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
```

*When running the helper as an orb the kube-score command will always exit succesfuly even if criticals occur.*


## Contributing?
Do you want to help out? Issues and pull requests are more than welcome. :D