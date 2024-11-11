---
title: Jupyter Hub
layout: page
parent: Components
---

# Jupyter Hub
[JupyterHub](https://jupyter.org/hub) brings the power of notebooks to groups of users. It gives users access to computational environments and resources without burdening the users with installation and maintenance tasks. Users - including students, researchers, and data scientists - can get their work done in their own workspaces on shared resources which can be managed efficiently by system administrators.

The Lancashire and South Cumbria Secure Data Environment uses a [customised version of the Jupyter Hub container](https://github.com/lsc-sde/docker-jupyterhub) that allows us to integrate workspace management capabilities which are embedded into the kubernetes control plane. This is supported by a [management portal](https://github.com/lsc-sde/docker-analytics-workspace-mgmt) that allows us to manage workspaces and membership to those workspaces giving us the ability to customise workspaces to individual needs of the analysis teams.

## Authentication / Authorization
The Lancashire and South Cumbria Secure Data Environment uses [OpenID Connect](https://www.microsoft.com/en-us/security/business/security-101/what-is-openid-connect-oidc) and [OAUTH2](https://oauth.net/2/) standards in order to allow users to connect to the system and manage roles based access controls.

The implementation of this is configurable based upon the cloud environment implemented such as:
* [Azure Entra ID](../../Infrastructure/Elastic-Compute-Resource/Microsoft-Azure/Entra-ID.md)

## Development
The following repositories relate to our implementation of this component:
* [Flux](https://github.com/lsc-sde/iac-flux-jupyter)
* [Jupyter Hub - Docker Image](https://github.com/lsc-sde/docker-jupyterhub)
* [Data Science Notebook](https://github.com/lsc-sde/docker-datascience-notebook-default)