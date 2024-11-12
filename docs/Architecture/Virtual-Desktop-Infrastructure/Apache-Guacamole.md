---
title: Apache Guacamole
parent: Virtual Desktop Infrastructure
grand_parent: Architecture
layout: page
---

[Apache Guacamole](https://guacamole.apache.org/) is a clientless remote desktop gateway. It supports standard protocols like VNC, RDP, and SSH.

## Database
The Lancashire and South Cumbria Secure Data Environment uses an external postgresql server to provide RDBMS functionality to the application. In a cloud environment it is expected that this will be a managed postgresql server for these such as:
* [Azure Database for Postgresql Server](../Infrastructure/Elastic-Compute-Resource/Microsoft-Azure/Postgresql-Server.md)

In a baremetal environment it is expected that you would install the database on a seperate server, however you can install locally if needed, but this is not provided for in the implementation at present.

# VDI
Apache Guacamole will make up part of the External Access Layer of the system. This will allow users from outside of the system to access the desktops of machines inside of our network via VNC or RDP.

Both Apache Guacamole and [keycloak](../Identity-and-Access-Management/Keycloak.md) can be made publicly accessible to provide public access to the solution while providing secure means to connect into the platform while ensuring workspace isolation.

```mermaid
flowchart LR
    a[User]
    -->|HTTPS Call| b[App Firewall]
    -->|HTTPS Forward| nginx[NGINX]
    -->|HTTPS Forward| guac[Apache Guacamole]
    -->|VNC Session| browser[Browser Container]
    -->|Browser HTTPS Call| jh[[Dynamic Compute Resource - Jupyter Hub]]
    
    k8s[K8S API]
    -->|Workspace Bindings| operator((AWMS Operator)) 
    -->|Connections and permissions| guacdb

    operator -->|Requests Deployments and Services| k8s
    
    operator -.->|Provisioned via K8s API| browser[Browser Container]
    
    guac --> guacdb[(Guacamole DB)]

    nginx -->|HTTPS Forward| kc[keycloak] -->|Requests Workspace Bindings for user and updates scale of workspace binding| k8s
    guac -.->|Auth via HTTPS| kc
```

Apache Guacamole is complimented by the [AWMS Guacamole Operator](../../imported/products/sde/analytics-workspace-management/awms-guacamole-operator/docs/operator.md) which provisions the browser containers for each workspace / user combination.  

