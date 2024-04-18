---
title: IAC
layout: page
parent: Infrastructure
has_children: true
has_toc: false
---

## Infrastructure as Code
IaC for the LSCSDE is split into 3 core types:
* [Helm Charts](./IAC/Helm.md)
* [Flux Charts](./IAC/FluxCD.md)
* [Terraform](./IAC/Terraform.md)

# GitOps Flow
There is a chain of flux and helm charts that work together in order to deploy an environment

```mermaid
flowchart LR
    Core[Core Flux Chart]
    -->
    CoreChart[Core Helm Chart]

    CoreChart --> aks_dns([AKS DNS Helm Chart])
    CoreChart --> analytics_workspace_management[AWMS Flux Chart] --> analytics_workspace_management_helm([AWMS Helm Chart]) 
    CoreChart --> cert_manager[Cert Manager Flux Configuration] --> cert_manager_helm([Cert Manager Helm Chart])
    CoreChart --> trust_manager([Trust Manager Helm Chart])
    CoreChart --> ingress_nginx[NGINX Flux Configuration] --> ingress_nginx_helm([NGINX Helm Chart])
    CoreChart --> jupyter_hub[Jupyter Hub Flux Configuration] --> jupyter_hub_helm([Jupyter Hub Helm Chart])
    CoreChart --> keda[Keda Flux Configuration] --> keda_helm([Keda Helm Chart])
    CoreChart --> metrics_server([Metrics Server Helm Chart])
    CoreChart --> ohdsi[OHDSI Flux Configuration] --> ohdsi_helm([OHDSI Helm Chart])
    CoreChart --> secrets_distributor[Secrets Distributor Flux Configuration] --> secrets_distributor_helm([Secrets Distributor Helm Chart])

    style CoreChart fill:#dddd00,stroke:#000000,color:#000
    style aks_dns fill:#dddd00,stroke:#000000,color:#000
    style analytics_workspace_management_helm fill:#dddd00,stroke:#000000,color:#000
    style cert_manager_helm fill:#f00,stroke:#000000,color:#fff
    style trust_manager fill:#f00,stroke:#000000,color:#fff
    style ingress_nginx_helm fill:#f00,stroke:#000000,color:#fff
    style jupyter_hub_helm fill:#f00,stroke:#000000,color:#fff
    style keda_helm fill:#f00,stroke:#000000,color:#fff
    style metrics_server fill:#f00,stroke:#000000,color:#fff
    style ohdsi_helm fill:#dddd00,stroke:#000000,color:#000
    style secrets_distributor_helm fill:#dddd00,stroke:#000000,color:#000

    style Core fill:#00f,stroke:#fff,color:#fff
    style analytics_workspace_management fill:#00f,stroke:#fff,color:#fff
    style cert_manager fill:#00f,stroke:#fff,color:#fff
    style ingress_nginx fill:#00f,stroke:#fff,color:#fff
    style jupyter_hub fill:#00f,stroke:#fff,color:#fff
    style keda fill:#00f,stroke:#fff,color:#fff
    style ohdsi fill:#00f,stroke:#fff,color:#fff
    style secrets_distributor fill:#00f,stroke:#fff,color:#fff

    click Core href "https://github.com/lsc-sde/iac-flux-lscsde" _blank
    click analytics_workspace_management href "https://github.com/lsc-sde/iac-flux-analytics-workspace-management" _blank
    click cert_manager href "https://github.com/lsc-sde/iac-flux-certmanager" _blank
    click ingress_nginx href "https://github.com/lsc-sde/iac-flux-nginx" _blank
    click jupyter_hub href "https://github.com/lsc-sde/iac-flux-jupyter" _blank
    click keda href "https://github.com/lsc-sde/iac-flux-keda" _blank
    click ohdsi href "https://github.com/lsc-sde/iac-flux-ohdsi" _blank
    click secrets_distributor href "https://github.com/lsc-sde/iac-flux-secrets-distributor" _blank


    click CoreChart href "https://github.com/lsc-sde/iac-helm-lscsde-flux" _blank
    click aks_dns href "https://github.com/lsc-sde/iac-helm-aks-dns-operator/" _blank
    click analytics_workspace_management_helm href "https://github.com/lsc-sde/iac-helm-analytics-workspace-management/" _blank
    click ohdsi_helm href "https://github.com/lsc-sde/iac-helm-ohdsi" _blank
    click secrets_distributor_helm href "https://github.com/lsc-sde/iac-helm-secrets-distributor" _blank
```