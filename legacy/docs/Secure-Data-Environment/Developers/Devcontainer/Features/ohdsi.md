---
title: Devcontainer Features - ohdsi
layout: page
parent: Devcontainer Guide
grand_parent: Developer Guide
nav_exclude: true
---

This feature include a collection of tools and scripts designed to make it easier to implement a standalone version of the OHDInetes implementation that will run on top of k3s inside of the devcontainer

### Usage

```json
{
    "features": {
        ...
        "ghcr.io/lsc-sde/devcontainer-features/ohdsi:0.1.1" : {
            "pathToHelmChart" : "${containerWorkspaceFolder}/lsc-sde/iac/helm/ohsdi"
        }
    }
}
```

### Options

| Name | Description | Default Value |
| --- | --- | --- |
| pathToHelmChart | The local path to the helm charts for installing OHDSI | /workspaces/lsc-sde/iac/helm/ohdsi |
| ohdsiNamespace | The kubernetes namespace where to install the OHDSI helm chart | ohdsi |

### Scripts
The following scripts are provided by this feature:

#### setup-ohdsi
The ***setup-ohdsi*** script will build and install OHDSI and its components and dependencies into the local cluster. This enabled rapid development and testing of the custom OHDSI packages used by the lsc-sde.
