---
title: Azure Entra
layout: page
nav_exclude: true
---

# Entra ID
[Azure Entra ID](https://learn.microsoft.com/en-us/entra/fundamentals/whatis) is used for identity and access management using app registrations to provide access via [OpenID Connect](https://www.microsoft.com/en-us/security/business/security-101/what-is-openid-connect-oidc) and [OAUTH2](https://oauth.net/2/) standards.

## App Registrations
App registrations are used to provide access to the following components:
* [OHDSI Atlas](../../../Components/OHDSI/Atlas.md)
* [Jupyter](../../../Components/Jupyter-Hub.md)

These app registrations are configured automatically via the [terraform for azure](https://github.com/lsc-sde/iac-terraform-azure).