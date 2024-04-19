---
title: Infrastructure
layout: page
has_toc: false
has_children: true
---

# Infrastructure
The Lancashire and South Cumbria Secure Data Environment is primarily designed to run on the cloud so that it can leverage [the elasticity of the cloud](./Infrastructure/Elastic-Compute-Resource.md), however we maintain the principles that the core solution should be able to run on any kubernetes cluster, even a bare metal implementations. Any components specific to azure (such as the AKS DNS Operator) should be interchangeable with equivalent components for other cloud solutions providers if someone would like to contribute an AWS, GCP or other version.

The solution is provisioned entirely via [Infrastructure as code](./Infrastructure/IAC.md)

# LSC SDE Specific Infrastructure
The LSC SDE hosted on the [LSC ICB Azure Landing Zone (private)](https://lthtr.sharepoint.com/:b:/r/sites/LSCSDELTH/Shared%20Documents/Development%20Team/Infrastructure/LSC%20ICB%20-%20Azure%20Landing%20Zone%20-%20Handover%20v1.0.pdf?csf=1&web=1&e=WCo7YE).