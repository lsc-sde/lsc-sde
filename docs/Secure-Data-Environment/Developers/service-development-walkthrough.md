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
At present, lscsde deployment is managed through a central [Flux repository](https://github.com/lsc-sde/iac-flux-lscsde)  along with two helm charts, one for provisioning the [components/microservices](https://github.com/lsc-sde/iac-helm-lscsde-flux) that make up the SDE and another for provisioning related k8s [namespaces](https://github.com/lsc-sde/iac-helm-lscsde-namespaces).

To integrate and test a microservice within the lscsde framework, these repositories require several modifications so that the flux configuration repository you've created for your microservice is included and provisioned when deployed to a particular cluster. Some of this configuration can be handled by the flux (i.e. [flux-release.yaml](https://github.com/lsc-sde/lsc-sde/blob/main/.github/workflows/flux-release.yaml)) and helm (i.e.[helm-release.yaml](https://github.com/lsc-sde/lsc-sde/blob/main/.github/workflows/helm-release.yaml)) release CICD workflows defined in the overaching [lsc-sde repository](https://github.com/lsc-sde/lsc-sde). However, such automated configurations are applied on the main branch only of the central flux and helm repositories. Therefore, given the branching strategy currently in use, if you want to provision your service on a development cluster, manual changes must be made to the central flux and helm repositories on the 'dev' branch.

#### LSCSDE Flux
To include your service flux configuration into the development cluster:
1. Checkout the [central flux configuration repository](https://github.com/lsc-sde/iac-flux-lscsde) dev branch
2. Edit/ensure the core/flux-config.yaml file includes a reference to your component that is similar to:
```yaml
  superset:
    repository:
      branch: release/0.1.16
  rabbitmq:
    repository:
      branch: release/0.1.18
```   
This configuration tells flux which branch of your flux configuration git repository to use for deployment. Once deployed, it's possible to confirm the correct branch is in use on the chosen development k8s cluster by running:
```bash
kubectl get gitrepository -n lscsde-config
``` 

It is also possible to specify helm chart versions to be used if needed in the core/helm-config,yaml. In both cases, these config files are used to create ConfigMap objects to support the configuration of subsequent flux repositories.

#### LSCSDE Helm

The central lscsde helm chart primarily specifies the components which should be deployed and the associated configuration properties for each. To quickly add your new service, you must do the following:
 * Checkout the [central flux helm repo](https://github.com/lsc-sde/iac-helm-lscsde-flux) on main branch (Note: we may want to establish a similar branching strategy to the flux-lscsde repo in future)
 * Under the templates/ directory:
 * Edit **deployment-configuration.yaml** to set up your services chart version and repo branch config variables specified in the values.yaml, for example:

{% raw %}
```yaml
rabbitmq_chart_version: {{ .Values.components.rabbitmq.chart_version }}
rabbitmq_branch: {{ .Values.components.rabbitmq.repository.branch }}
```
{% endraw %}

 * Edit **deployment-namespaces.yaml** to define the namespace config variable specified in this charts values.yaml. This is used during deployment to create the namespace where the microservice components will be deployed into, for example:
{% raw %}
```yaml
rabbitmq_namespace: {{ .Values.components.rabbitmq.namespace }}
``` 
{% endraw %}
 * Edit **values.yaml** in the root directory with an entry for the mircoservice. This should include values for variables used when customising the microservice during installation of the lscsde chart, for example:
```yaml
   rabbitmq:
     state: "enabled"
     namespace: rabbitmq
     chart_version: ""
     repository:
       name: rabbitmq
       url: https://github.com/lsc-sde/iac-flux-rabbitmq
       branch: main
       requiresAuth: false
       secret:
         usernameKey: ""
         passwordKey: ""
```

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
