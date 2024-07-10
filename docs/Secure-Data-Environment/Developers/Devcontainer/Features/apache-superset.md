---
title: Devcontainer Features - apache-superset
layout: page
parent: Devcontainer Guide
grand_parent: Developer Guide
nav_exclude: true
---

This feature includes a collection of tools and scripts designed to make it easier to interop with Azure Resource Manager and AKS.

### Usage

```json
{
    "features": {
        ...
		"ghcr.io/lsc-sde/devcontainer-features/apache-superset:0.1.0" : {}
    }
}
```

### Options
There are currently no options for the apache superset feature

### Scripts
The following scripts are provided by this feature:

#### setup-apache-superset
The ***setup-apache-superset*** command will build the container images and deploy Apache Superset to the namespace *superset-test*

Once deployed you should be able to expose this by forwarding the port
```bash
kubectl port-forward service/superset-test 8088:8088 --namespace superset-test
```