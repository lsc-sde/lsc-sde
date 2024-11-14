---
title: GitOps Flow
layout: page
parent: Infrastructure as Code
grand_parent: Developer Guide
nav_order: 1
---

There is a chain of flux and helm charts that work together in order to deploy an environment

```mermaid
flowchart LR
    Core[Core Flux Chart]
    -->
    NamespaceFlux[Namespaces Flux]
    -->
    NamespaceChart([Namespaces Helm Chart])
    
    Core --> CoreChart([Core Helm Chart])
    --> ServiceFlux[Service Flux]
    --> ServiceChart([Service Helm Chart])

    NamespaceFlux -.->|Dependency| ServiceFlux
    NamespaceChart -.->|Dependency| ServiceChart
```

## Applying Hot-Fixes
When applying hot fixes to the environment we will typically identify the product branch effected from the [core flux repository](https://github.com/lsc-sde/iac-flux-lscsde). This repository uses a [different branching strategy](../Source-Control/Branching-Strategies/Core-Flux-Strategy.md) to the majority of the others.

This allows us to control which environment is using which version of the code and subsequently what versions of the various components we are using.

Once you've checked out the latest prod branch, you can then look at the release version for the effected component(s) by looking in either:
* core/flux-config.yaml
* core/helm-config.yaml
* core/release.yaml

Looking into these files should tell you which version the components are, so say for making a change in prod that impacts the jupyter components, you will look into the core/deployment-config.yaml file and look for jupyter_branch and/or jupyter_chart_version. The branch is the branch in the [jupyter flux repository](https://github.com/lsc-sde/iac-flux-jupyter), the chart version is the version of the jupyter hub helm chart we're using.

### Example Flux Config
```yaml
components:
  aks_dns:
    repository:
      branch: main
  analytics_workspace_management:
    repository:
      branch: "release/0.1.19"
  cert_manager:
    repository:
      branch: "release/0.1.40"
  github_runner:
    repository:
      branch: "release/0.1.56"
  ingress_nginx:
    repository:
      branch: "release/0.1.61"
  jupyter_hub:
    repository:
      branch: "release/0.2.105"
  keda:
    repository:
      branch: "release/0.1.44"
  metrics_server:
    repository:
      branch: main
  ohdsi:
    repository:
      branch: "release/0.1.70"
  secrets_distributor:
    repository:
      branch: "release/0.1.6"
  guacamole:
    repository:
      branch: release/0.1.21
  superset:
    repository:
      branch: release/0.1.16
  rabbitmq:
    repository:
      branch: release/0.1.20
  observability_metrics:
    repository:
      branch: release/0.1.42
  keycloak:
    repository:
      branch: release/0.1.70
  awms_guacamole:
    repository:
      branch: release/0.1.28
  observability-metrics:
    repository:
      branch: release/0.1.45
```

### Example Helm Config
```yaml
components:
  aks_dns:
    chart_version: "0.2.13"
  analytics_workspace_management:
    chart_version: "0.1.37"
  cert_manager:
    chart_version: "v1.14.2"
  github_runner:
    chart_version: "0.1.28"
  ingress_nginx:
    chart_version: "4.11.1"
  jupyter_hub:
    chart_version: "3.2.1"
  keda:
    chart_version: "2.13.1"
  metrics_server:
    chart_version: "3.12.0"
  ohdsi:
    chart_version: "0.1.35"
  secrets_distributor:
    chart_version: "0.2.14"
  guacamole:
    chart_version: "0.1.15"
  awms_guacamole:
    chart_version: 0.1.28
```

### Example Image Config
```yaml example image-config.yaml
components:
  keycloak:
    image: lscsde/awms-keycloak:0.1.8
  awms_guacamole:
    image: lscsde/awms-guacamole-operator:0.1.28
```

You can see from the above that in this instance we'd be looking for branch **release/0.2.105** in the [jupyter flux repository](https://github.com/lsc-sde/iac-flux-jupyter). We will then checkout the repository which will use the standard branching strategy.

```mermaid
gitGraph LR:
    commit
    commit
    branch release/0.2.105
    checkout release/0.2.105
    commit id: "Release"
    
    branch hotfix/123
    checkout hotfix/123
    commit id: "Hot Fix"

    switch release/0.2.105
    merge hotfix/123
    commit id: "PR to release branch"

    switch main
    merge release/0.2.105
    commit id: "PR to main branch"
```

We will create a hotfix branch based upon the branch currently in use by this environment.

Once we have completed the changes and tested as throughly as we can we will PR this back into the release branch which we created the hotfix branch from. This will cause any environments using this version of the flux configuration to be updated within 10 minutes. We will watch the environment to make sure that this has the desired effect and once completed, we will then PR from the release branch back into the main branch to carry the change forward.