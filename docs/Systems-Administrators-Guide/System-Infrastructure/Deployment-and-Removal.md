---
title: Deployment and Removal
parent: System Infrastructure
grand_parent: Systems Administrators Guide
layout: page
---

The SDE core infrastructure is deployed primarily through [infrastructure as code](../../Developer-Guide/IAC.md). This is initially [Terraform](../../Developer-Guide/IAC/Terraform.md), which in turn calls [FluxCD](../../Developer-Guide/IAC/FluxCD.md) and [Helm Charts](../../Developer-Guide/IAC/Helm.md). This allows us to provision and destroy whole environments quickly and easily and makes deployment repeatable, allowing multiple environments to be provisioned as needed to fulfil the organisation's testing and deployment strategy.