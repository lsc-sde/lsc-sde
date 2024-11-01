---
title: Devcontainer Features - jupyterhub
layout: page
parent: Devcontainer Guide
grand_parent: Developer Guide
nav_exclude: true
---

This feature installs tools and scripts that allow a standalone version of Jupyter Hub to be installed alongside all of the tools needed for the LSC-SDE's Analytics Workspace Management Solution (AWMS), allowing us to rapidly develop and test new features for both tools inside of the devcontainer.

### Usage

```json
{
    "features": {
        ...
		"ghcr.io/lsc-sde/devcontainer-features/jupyterhub:0.1.1" : {
			"hubDockerImageDefinition" : "${containerWorkspaceFolder}/lsc-sde/docker/jupyterhub",
			"analyticsWorkspaceHelmChart" : "${containerWorkspaceFolder}/lsc-sde/iac/helm/analytics-workspace-management"
		}
    }
}
```

### Options

| Name | Description | Default Value |
| --- | --- | --- |
| helmRepository | The URL to the helm chart repository used to deploy jupyter hub | https://jupyterhub.github.io/helm-chart/ |
| chartName | The name of the chart used to deploy jupyter hub | jupyterhub |
| chartVersion | The version of the chart used to deploy jupyter hub | 3.2.1 |
| namespace | The namespace where jupyterhub will be installed | jh-test |
| imageName | The name of the image to create when building jupyterhub images | k3d-devcontainer-registry.local:36471/jupyterhub |
| imageTag | The tag to create when building jupyterhub images | local |
| hubDockerImageDefinition | The path to the jupyter hub docker image | /workspaces/lsc-sde/docker/jupyterhub |
| analyticsWorkspaceHelmChart | The path to the analytics workspace management helm chart | /workspaces/lsc-sde/iac/helm/analytics-workspace-management/ |

### Scripts
The following scripts are provided by this feature:

#### setup-jupyterhub
The ***setup-jupyterhub*** script will build and install jupyterhub and its components and dependencies into the local cluster. This enabled rapid development and testing of the custom jupyterhub packages used by the lsc-sde.
