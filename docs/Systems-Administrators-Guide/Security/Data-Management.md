---
title: Data Management
parent: Security
grand_parent: Systems Administrators Guide
layout: page
---

## Encryption at rest
It is recommended when implementing the solution that you should encrypt all data at rest. When implemented on Cloud Infrastructure such as Azure, Encryption at rest is handled by the cloud provider. It is recommended that you further secure the solution by enabling customer managed encryption keys on the storage accounts that are provisioned. This is configured by default via the [terraform](../../Developer-Guide/IAC/Terraform.md) scripts which deploy the infrastructure.

## Disaster Recovery
It is recommended that system implementers put in place appropriate disaster recovery solutions to protect their data. When implemented on cloud providers, this is handled by the provider. By default the storage accounts should be configured the [terraform](../../Developer-Guide/IAC/Terraform.md) scripts to be set to at least utilise zone redundant storage.   

## Backups
It is recommended that system implementers put in place appropriate backups to protect their data. 