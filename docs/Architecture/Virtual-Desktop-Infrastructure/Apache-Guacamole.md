---
title: Apache Guacamole
parent: Virtual Desktop Infrastructure
grand_parent: Architecture
layout: page
---

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

