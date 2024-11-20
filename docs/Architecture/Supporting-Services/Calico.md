---
title: Calico
layout: page
parent: Supporting Services
grand_parent: Architecture
has_children: true
---

[Tigera Calico](https://docs.tigera.io/calico/latest/about/) is a networking and security solution that enables Kubernetes workloads and non-Kubernetes/legacy workloads to communicate seamlessly and securely.

Calico enforces the network policies defined within Kubernetes resource definitions and provides custom extensions to further extend those default capabilities.

Each service implements it's own Network Security Policies as part of it's individual [FluxCD configuration](../../Developer-Guide/IAC/FluxCD.md). The default network policies for the solution are listed below.


```mermaid
flowchart LR
    internet([Internet]) -->|HTTPS| nginx 

    jupyterhub[Jupyter Hub] -->|HTTPS| jupyterproxy
    jupyterproxy[Jupyter Proxy] -->|HTTPS| jupyternotebook[Jupyter Notebook]
    
    nginx <-->|HTTPS| jupyterhub

    nginx <-->|HTTPS| ohdsi[OHDSI]
    nginx <-->|HTTPS| keycloak[Keycloak Instance]
    nginx -->|HTTPS| guac[Apache Guacamole]
    nginx -->|HTTPS| kubernetes[[Kubernetes API]]
    nginx <-->|HTTPS| superset[Apache Superset]

    jupyterhub --> |HTTPS| kubernetes
    
    keycloak_operator[Keycloak Operator] -->|HTTPS| kubernetes
    aks_dns_operator[AKS DNS Operator] -->|HTTPS| kubernetes
    guacamole_operator[AWMS Guacamole Operator] -->|HTTPS| kubernetes
    secrets_distributor[Secrets Distributor] -->|HTTPS| kubernetes
    keycloak -->|HTTPS| kubernetes

    jupyternotebook --> |HTTPS| internet

    keycloak --> |Port 5432| postgresql([PostgreSQL Server])
    ohdsi --> |Port 5432| postgresql
    guac --> |Port 5432| postgresql
    guacamole_operator --> |Port 5432| postgresql
    superset --> |Port 5432|postgresql
    aks_dns_operator --> |HTTPS| internet
    secrets_distributor --> |HTTPS| internet

    cert_manager[Cert Manager] -->|HTTPS|kubernetes
    keda[KEDA] -->|HTTPS|kubernetes
    nginx --> |HTTPS|rabbitmq[RabbitMQ]
    nginx -->|HTTPS|prometheus[Prometheus]

    prometheus -->|HTTPS|kubernetes
```