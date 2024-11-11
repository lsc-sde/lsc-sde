---
title: Keycloak
parent: Identity and Access Management
grand_parent: Architecture
layout: page
---

Keycloak is an open source identity and access management system, all applications within the solution will authenticate to keycloak which in turn can then hook into a variety of external identity providers such as:

* LDAP
* Azure Entra (formerly Azure Active Directory)
* AWS SSO
* Google Cloud Identity
* etc

This provides a great deal of flexibility within the solution while providing a firm configuration for the setup of the individual application that the solution exposes to its users.