---
title: FluxCD
layout: page
parent: Infrastructure as Code
grand_parent: Developer Guide
---

[Flux](https://fluxcd.io/) is a set of continuous and progressive delivery solutions for Kubernetes that are open and extensible.

## Core Configurations
* [lscsde](https://github.com/lsc-sde/iac-flux-lscsde)

## Supporting Configurations
* [keda](https://github.com/lsc-sde/iac-flux-keda)
* [certmanager](https://github.com/lsc-sde/iac-flux-certmanager)
* [nginx](https://github.com/lsc-sde/iac-flux-nginx/)

## Application Configurations
* [Analytics Workspace Management](https://github.com/lsc-sde/iac-flux-analytics-workspace-management)
* [Jupyter Hub](https://github.com/lsc-sde/iac-flux-jupyter)
* [Prefect Server](https://github.com/lsc-sde/iac-flux-prefect-server)
* [OHDSI](https://github.com/lsc-sde/iac-flux-ohdsi)
* [Keycloak](https://github.com/lsc-sde/iac-flux-keycloak) - deprecated

## Utility Configurations
* [Github Action Runners](https://github.com/lsc-sde/iac-flux-github-action-runners/)

The core flux configuration to call is the [lscsde flux configuration](https://github.com/lsc-sde/iac-flux-lscsde), this will cascade create all of the other helm releases and flux configurations as required for the environment.