---
title: Devcontainer Features - lscsde
layout: page
parent: Devcontainer Guide
grand_parent: Developer Guide
nav_exclude: true
---

This feature includes a collection of tools and scripts designed to allow development and deployment of the LSCSDE in various environments allowing LSCSDE developers, testers and release managers to work on this project with all the tools needed at their disposal.

### Usage

```json
{
    "features": {
        ...
		"ghcr.io/lsc-sde/devcontainer-features/lscsde:0.1.1" : {
			"secretsPath" : "${containerWorkspaceFolder}/lsc-sde/.devcontainer/k3d/volume/secrets",
			"coreFluxWorkspaceFolder" : "${containerWorkspaceFolder}/lsc-sde/iac/flux/lscsde"
		}
    }
}
```

### Options

| Name | Description | Default Value |
| --- | --- | --- |
| fluxRepoUrl | The URL to the repository where flux charts are setup  | https://github.com/lsc-sde/iac-flux-lscsde |
| fluxRepoPath | The path in the flux chart repository pertaining to this environment | ./clusters/devcontainer-local |
| secretsPath | The path where secrets are mounted inside of the container | /workspaces/lsc-sde/.devcontainer/k3d/volume/secrets |
| coreFluxWorkspaceFolder | The path to the core flux folder in the local workspace  | /workspaces/lsc-sde/iac/flux/lscsde |

### Scripts
The following scripts are provided by this feature:

#### cleanup-lscsde
The ***cleanup-lscsde*** command deletes the resources related to the lscsde.

#### fix-metrics-server
The ***fix-metrics-server*** command amends the ownership of metrics server resources so that they are managed by the helm chart

#### generate-password-lscsde
The ***generate-password-lscsde*** command generates a random password for use in local secrets

#### setup-lscsde
The ***setup-lscsde*** command installs the kustomizations into the local k3s cluster using the current selected branch of the flux repository. 

#### setup-terminal-lscsde
The ***setup-terminal-lscsde*** command sets up the bash terminal so that it has access to the secrets.

This is called on container start

#### sync-keyvault-lscsde
The ***sync-keyvault-lscsde*** command synchronises the local secrets with the values in the specified keyvault

#### tf-apply
The ***tf-apply*** command is a shortcut to calling *terraform apply* that automatically applies the correct tfvars file based upon the workspace selected.

#### tf-plan
The ***tf-plan*** command is a shortcut to calling *terraform plan* that automatically applies the correct tfvars file based upon the workspace selected.

#### tf-import
The ***tf-import*** command is a shortcut to calling *terraform import* that automatically applies the correct tfvars file based upon the workspace selected.