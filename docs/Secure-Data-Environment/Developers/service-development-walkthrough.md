---
title: Service Development Guide
layout: page
parent: Developer Guide
---
# Service Development Guide
    - Practical guide to developing, deploying and testing a base microservice (rabbitmq) within the lscsde framework
    - Avoid gotchas
    - Document 

### Project Definition
Prior to the development of a lscsde mircoservice, it is important to assess what type of service resources are needed and the requirements such a service should address. In most cases, you will be able to build on an existing service that can be deployed resources within a k8s cluster through Helm or git repos. For example, in the case of requiring a messaging broker, a number of open source projects exist (e.g. rabbitmq, kafka, mosquito) that simplify the provision of such services through official helm chart repositories. A chart ensures base resources required to operate and serve a messaging service in K8s are installed. Therefore, in most cases, the development of a service would primarily focus on a process for the installation and configuration of base resources along with the extension of such services through further adaptations (i.e. kustomizations). To do this, the lscsde follows a declarative gitops approach and relies on FluxCD to manage the deployment and state of microservices. Therefore, to begin, create a git repository that can house the fluxCD configuration for your chosen microservice and can be associated with the master lscsde flux repository.

    - Go to github, create repo
    - Open vscode, clone root project of the lscsde framework
    - Add xyz flux repo as a submodule (iac-flux-xyz)

Next we need to define some initial config that flux can use to signal the installation of the rabbitmq helm chart. To do this we define config to initialise helmrelease and helmrepository resources that the flux operators can use to install the base rabbitmq resources via the helm chart.  

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
