---
title: Devcontainer Features - aks-tools
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
		"ghcr.io/lsc-sde/devcontainer-features/aks-tools:0.1.1" : {}
    }
}
```

### Options

| Name | Description | Default Value |
| --- | --- | --- |
| clusterName | The name of the k3s cluster where the tools would be configured against | devcontainer |

### Scripts
The following scripts are provided by this feature:

#### setup-aks
The ***setup-aks*** command will use the *az cli* to scan for kubernetes clusters and will map those clusters into your kubeconfig, allowing you to login to the clusters.

By default it will attempt to add all clusters that are visible the *az cli* and then switch back to the default context which will be the devcontainers own k3s cluster. 

```bash
setup-aks lscsdedev-k8s
```

Should provide the following output:

```text
Adding lscsdedev-k8s in lscsdedev-rg
Merged "lscsdedev-k8s" as current context in /home/node/.kube/config
Adding lscsdestg-k8s in lscsdestg-rg
Merged "lscsdestg-k8s" as current context in /home/node/.kube/config
Switched to context "k3d-devcontainer".
```

If however you specify a specific cluster name, it will add just the specified cluster to the kubeconfig and switch contexts to that cluster. This creates a nice shortcut to switching context:


```bash
setup-aks lscsdedev-k8s
```

This should provide the following output:

```text
Adding lscsdedev-k8s in lscsdedev-rg
Merged "lscsdedev-k8s" as current context in /home/node/.kube/config
Switched to context "lscsdedev-k8s".
```