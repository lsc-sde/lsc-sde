---
title: Devcontainer Features - fluxcd
layout: page
parent: Devcontainer Guide
grand_parent: Developer Guide
nav_exclude: true
---

This feature is an implementation of fluxcd that runs on top of k3d in the devcontainer

### Usage

```json
{
    "features": {
        ...
		"ghcr.io/lsc-sde/devcontainer-features/fluxcd:0.1.1" : {}
    }
}
```

### Scripts
The following scripts are provided by this feature:

#### setup-fluxcd
This script installs fluxcd into the current kubeconfig context and is basically a shortcut to the *flux install* command

This is automatically called on container startup after k3d is provisioned