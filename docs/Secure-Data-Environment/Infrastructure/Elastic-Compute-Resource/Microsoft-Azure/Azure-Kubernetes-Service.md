---
layout: page
---

# Azure Kubernetes Service
[Azure Kubernetes Service (AKS)](https://azure.microsoft.com/en-gb/products/kubernetes-service) is used to provide a managed kubernetes cluster inside of Azure.

In order to avoid network issues, the server utilises [kubenet](https://learn.microsoft.com/en-us/azure/aks/configure-kubenet) networking and [calico security](https://learn.microsoft.com/en-us/azure/aks/use-network-policies#differences-between-network-policy-engines-cilium-azure-npm-and-calico). 