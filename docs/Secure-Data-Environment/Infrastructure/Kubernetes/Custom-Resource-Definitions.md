---
title: CRDs
layout: page
parent: Kubernetes
grand_parent: Infrastructure
---

# Custom Resource Definitions
The Lancashire and South Cumbria Secure Data Environment (LSC-SDE) leverages [Kubernetes Custom Resource Definitions](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/) to store and manage resource definitions.

By using the CRD's in kubernetes these integrate seemlessly with the kubernetes and operator frameworks, this provides schema management, automatic API generation, API Security and audit mechanisms and via the operator framework a methodology to use these definitions to orchestrate functionality based on these definitions. 

## Available Custom Resource Definitions
* [Analytics Workspaces](../../Components/Analytics-Workspace-Management-Solution/Analytics-Workspaces.md)
* [Analytics Workspace Binding](../../Components/Analytics-Workspace-Management-Solution/Analytics-Workspace-Bindings.md)
