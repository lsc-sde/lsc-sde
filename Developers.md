# Getting Setup
The following is a guide to getting setup with all the tools needed to run the environment locally.

## Docker Desktop (for windows)
A guide to installing docker desktop is available on the the docker desktop website:

https://docs.docker.com/desktop/install/windows-install/

It is recommended to use WSL2 to run docker desktop rather than windows hypervisor. Once docker desktop is installed, you can test by running the following command:

```
docker ps
``` 

If the above command does not throw any exception, run nothing. Once completed and functioning correctly, you will need to install kubernetes:

https://docs.docker.com/desktop/kubernetes/

Once install is completed, you can switch context and run basic commands on the local cluster:

```powershell 
kubectl config use-context docker-desktop
kubectl get namespaces 
```

This should return a list of namespaces on the cluster.

## Helm
Instructions for installing helm can be found on the helm website:

https://helm.sh/docs/intro/install/


## Flux
Installation for installing flux can be found on the flux website:

https://fluxcd.io/flux/installation/

Once installed you can then install the various components using the instructions present in [each flux repository](./iac/flux/). It is recommended that you install any components classified as core-components

## Azure CLI
Instructions for installing the Azure CLI can be found on the azure website:

https://learn.microsoft.com/en-us/cli/azure/install-azure-cli

Once installed, you can login via the following command

```bash
az login --tenant f12f0279-8a84-4068-8322-7a6fb0f839b8
```

This assumes that you are going to be talking to the LSCICS.onmicrosoft.com tenant and in all likeliness that this will not be the only tenant that you are a member of.

## Terraform
Instructions for installing terraform are available on the hashicorp website:

https://developer.hashicorp.com/terraform/install

