---
title: Secrets Distributor
layout: page
parent: Environment Specific Components
grand_parent: Architecture
has_children: true
---

The secrets distributor is responsible to copying secrets around kubernetes allowing them to be used in pod definitions in multiple namespaces, Further information can be found in the [Secrets Distributor](./docker/secrets-distributor/) repository

## Development
The following repositories relate to our implementation of this component:
* [Docker Image](https://github.com/lsc-sde/docker-secrets-distributor)
* [Helm](https://github.com/lsc-sde/iac-helm-secrets-distributor)