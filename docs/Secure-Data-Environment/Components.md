---
title: Components
layout: page
has_toc: false
has_children: true
---

# Components of LSC-SDE
```mermaid
mindmap
  root((LSCSDE))
    (General)
      Secrets Distributor
      ::icon(fas user-secret)
      Cert Manager
      ::icon(fas certificate)
      Trust Manager
      ::icon(fas key)
      Nginx
      ::icon(fas users)
      Keda
      ::icon(fas exchange-alt)

    (Azure Specific)
      AKS DNS Operator
    (User Access)
      Apache Guacamole
    (Analytics)
      JupyterHub
      OHDSI
        Atlas
        Hades
    (Management)
      LSC SDE Management Portal
```


## General Components
* [Secrets Distributor](./Components/Secrets-Distributor.md)
* [Cert Manager](./Components/Cert-Manager.md)
* [Trust Manager](./Components/Trust-Manager.md)
* [Nginx](./Components/Nginx.md)
* [Keda](./Components/Keda.md)
## Management
* [Analytics-Workspace-Management-Solution](./Components/Analytics-Workspace-Management-Solution.md)
## User Access
* [Apache Guacamole](./Components/Apache-Guacamole.md)
## Azure Specific Components
* [AKS DNS Operator](./Components/Azure-Specific/AKS-DNS-Operator.md)
## Analytics
* [Jupyterhub](./Components/Jupyter-Hub.md)
* [OHDSI](./Components/OHDSI.md)