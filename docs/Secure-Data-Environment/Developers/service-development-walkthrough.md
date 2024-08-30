---
title: Service Development Guide
layout: page
parent: Developer Guide
---
# Service Development Guide
    - Practical guide to developing, deploying and testing a base microservice within the lscsde framework
    - Avoid gotchas
    - Document 

### Project Definition
How to create and allocate service dev repo within lscsde framework  
    - public repo
    - add as submodule to lscsde (flux typically goes in iac/flux - link to suggested design)

### GitOps & Cluster Deployment
Steps to integrate a microservice into lscsde gitops/flux model and target cluster
    - iac-flux-lscsde
        - important info about branching for dev, staging, prod clusters
        - flux-config.yaml entries needed
    - iac-helm-lscsde
        - Add entries in values.yaml
        - Add entries deployment-config
        - Add entries namespace config

### Service Kustomizations & Overlays
    - Managing and structuring dependencies

### Public Access
    - Dev vs prod routing
        - kubectl port-forward
        - nginx ingress controller
    - Ingress
        - Annotations
    - TLS (secrets distributor)
        - Wildcard cert/key

### Security & Authentication 
    - Cluster roles & service accounts
    - Self-contained Identity provider abstraction (keycloak)
    - how to integrate a service with keycloak auth?

### Testing 
    - Do as much testing on cluster devcontainer
        - However, somethings like not possible (i.e. ingress, integrating with gitops model)
    - Jumpbox for dev cluster
        - Limitation of having to be on nhs network to access devcluster
        - need to install kubectl, etc :/

### Common Gotchas
    - flux overlays unable to access gitrepository in lscsde-config namespace  
