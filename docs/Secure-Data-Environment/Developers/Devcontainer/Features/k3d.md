---
title: Devcontainer Features - k3d
layout: page
parent: Devcontainer Guide
grand_parent: Developer Guide
nav_exclude: true
---

This feature is an implementation of k3d on top of docker-in-docker the allows for running a kubernetes instance from within the devcontainer

### Usage

```json
{
    "features": {
        ...
		"ghcr.io/lsc-sde/devcontainer-features/k3d:0.1.1" : {}
    }
}
```

### Options

| Name | Description | Default Value |
| --- | --- | --- |
| hostVolumePath | The container path where volumes are mounted | /var/lib/rancher/k3s/storage |
| secretsPath | The container path where secrets are mounted | /var/lib/rancher/k3s/storage/secrets |
| installCalico | if true then calico will be installed onto the provisioned k3s cluster | true |
| clusterName | The name of the k3s cluster to be provisioned | devcontainer |
| disableTraefik | if true, then Traefik is disabled | true |
| disableFlannel | If true, then Flannel is disabled | true |
| disableLoadBalancer | If true, then the default load balancer is disabled | false | 
| registryPort | The port used by the k3s registry provisioned | 36471 |

### Scripts
The following scripts are provided by this feature:

#### cleanup-k3d
The ***cleanup-k3d*** command checks to see if the k3d instance for this devcontainer exists, and if so it will delete it allowing for a fresh setup.

Following using this command it is recommended that you rebuild your devcontainer in order to ensure that the instance is rebuilt in a consistent manner.

#### setup-k3d
The ***setup-k3d*** command checks to see if the k3d registry and cluster exists, if not it will create it, if so it will merge in the configuration to the containers kubeconfig.

This script is run automatically on container start