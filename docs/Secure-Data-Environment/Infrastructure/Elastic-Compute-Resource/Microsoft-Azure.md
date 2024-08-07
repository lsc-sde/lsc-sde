---
title: Microsoft Azure
layout: page
parent: Elastic Compute Resource
grand_parent: Infrastructure
---

# Microsoft Azure
The Lancashire and South Cumbria Secure Data Environment leverages [Kubernetes](https://kubernetes.io/) on [Microsoft Azure](https://azure.microsoft.com/en-gb/products/kubernetes-service) to provide the Elasticity of the solution, it dynamically provisions additional nodes as required by individual workspaces. This allows us to quickly and easily dynamically provision compute, memory and GPU resource as is suitable for a specific resource project.

![LSCSDE on Azure](./Microsoft-Azure/LSCSDE-Azure.png)

AKS in this instance provides the kubernetes cluster and supporting components that allow us to interact with the Azure estate in order to expose services to the network and to the internet, provide persistent volumes and secrets and key management. The AKS cluster also installs [FluxCD](../IAC/FluxCD.md) onto the server via an AKS extension, this allows the [terraform scripts](../IAC/Terraform.md) to deploy LSCSDE and its supporting components onto the AKS cluster via a GitOps methodology.

[Infrastructure in Azure is provisioned using terraform](https://github.com/lsc-sde/iac-terraform-azure)

## Components
```mermaid
mindmap
  root)AKS(
    Storage Account
        File Share
        Blob Storage
    Virtual Network
        Private DNS Zone
        Private Endpoints
    Diagnostics Workspace
    Postgresql Server
    Entra ID
        App Registrations
        Users
    KeyVault
        Secrets
        Keys
```

* [Azure Kubernetes Service](./Microsoft-Azure/Azure-Kubernetes-Service.md)
* [Diagnostics Workspace](./Microsoft-Azure/Diagnostics-Workspace.md)
* [Entra ID](./Microsoft-Azure/Entra-ID.md)
* [Storage Account](./Microsoft-Azure/Storage-Accounts.md)
* [Virtual Network](./Microsoft-Azure/Virtual-Network.md)