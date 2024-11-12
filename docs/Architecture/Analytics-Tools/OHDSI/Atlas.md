---
title: Atlas
layout: page
parent: OHDSI
grand_parent: Analytics Tools
---

# OHDSI ATLAS
OHDSI ATLAS is a free, publicly available, web-based tool developed by the OHDSI community that facilitates the design and execution of analyses on standardized, patient-level, observational data in the CDM format.

OHDSI Atlas makes use of the [OHDSI Web API](./WebAPI.md)

## Authentication / Authorization
The Lancashire and South Cumbria Secure Data Environment uses [OpenID Connect](https://www.microsoft.com/en-us/security/business/security-101/what-is-openid-connect-oidc) and [OAUTH2](https://oauth.net/2/) standards in order to allow users to connect to the system and manage roles based access controls.

The implementation of this is configurable based upon the cloud environment implemented such as:
* [Azure Entra ID](../../Infrastructure/Elastic-Compute-Resource/Microsoft-Azure/Entra-ID.md)

## Development
The following repositories relate to our implementation of this component:
* [Forked Repository](https://github.com/lsc-sde/fork-ohdsi-atlas)
* [Customised Docker Image](https://github.com/lsc-sde/docker-ohdsi-atlas)