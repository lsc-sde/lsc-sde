---
title: Software Tools
parent: Security
grand_parent: Systems Administrators Guide
layout: page
---

## Access
The entrypoint to the solution is via [Apache Guacamole](../../Architecture/Virtual-Desktop-Infrastructure/Apache-Guacamole.md) which allows users to access the solution using any modern browser, such as Mozilla Firefox, Microsoft Edge, Google Chrome, etc.

## Researcher Documentation
The solution provides guidance to [Research Engineers](../../Researcher-Guide.md) on [how to make use of the system](../../Researcher-Guide/Getting-Started.md) and the [available tools](../../Researcher-Guide/Available-Tools.md).

## Security Updates
The solution is hosted upon a kubernetes cluster, it is recommended to systems implementers that the nodes of these clusters should be automatically updated with the latest security patches. The containers themselves use container images to run. 

These container images are versioned and static to allow proper testing to take place in a new environment before software updates are applied. It is the responsibility of each system implementer to ensure that their images are updated and tested as appropriate.

It is recommended that services that are publicly facing, such as [Keycloak](../../Architecture/Identity-and-Access-Management/Keycloak.md) and [Apache Guacamole](../../Architecture/Virtual-Desktop-Infrastructure/Apache-Guacamole.md) are prioritised. It is also recommended that you an application firewall should be implemented in front of these services. 

## Shared Services
Users of a workspace are provided with shared resources such as [persistent storage volumes](../../Architecture/Dynamic-Compute-Resource/PVCs.md) that allows all users of a workspace to be able to access. This enables users to collaborate on the project.

## Unnecessary Software
Due to the containerised nature of the solution, each container should contain the tools necessary for the container to function as well as any prerequisites. At a result unnecessary software should not be included on the container images. When the solution is implemented software on any nodes should be also limited to what is necessary. 

## Service Accounts 
All containers should utilise non-root accounts to safeguard the container image and the kernels of the solution.

## User Accounts
System implementers can manage user access via keycloak itself or utilise keycloaks capabilities to interact with other identity providers to provide access.

### Password Policies
It is the responsibility of each system implementer to ensure password policies and practice are configured per industry standards and your organisations password policies. We also recommend that any default passwords are reset.