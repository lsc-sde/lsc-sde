---
title: Custom Labels
layout: page
parent: Developer Guide
nav_order: 3
---

| Label | Purpose | Applies to.. |
| --- | --- | --- |
| xlscsde.nhs.uk/appType | The type of Application exposed by the pod in question, this is used by Network Policies to differentiate different pods in the same group | Pods |
| xlscsde.nhs.uk/dns-record | Lets the DNS Operators know that a private DNS entry needs to be created/managed for this resource. | Ingresses, Services |
| xlscsde.nhs.uk/nodeSize | The size name of the node, this is used for keeping track of tolerances to assign resources | Pods |
| xlscsde.nhs.uk/managedBy | Used by operator to ensure that any resources created by the operator are managed by that resource, rather than any other operator. Allowing us to have multiple instances of the same operator running on a single cluster | Any |
| xlscsde.nhs.uk/secretUsage | A description of what a secret is used for | Secret |
| xlscsde.nhs.uk/type | The sub type of a resource, used by operators to differentiate between resources of the same type  | [AnalyticsWorkspaceDataSources](./Custom-Resources/AnalyticsWorkspaceDataSources.md) |
| xlscsde.nhs.uk/workspace | The name of the workspace that this resource pertains to. | Pods |
| xlscsde.nhs.uk/username | A formatted version of the username field that can be used to efficiently search for users | [AnalyticsWorkspaceBindings](./Custom-Resources/AnalyticsWorkspaceBindings.md) |
