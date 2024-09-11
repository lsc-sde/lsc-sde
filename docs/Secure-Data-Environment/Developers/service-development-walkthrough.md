---
title: Service Development Guide
layout: page
parent: Developer Guide
---
# Service Development Guide

This guide is for infrastructure and application developers looking to gain a broad understanding of how to develop and deploy microservices within the lscsde. Using rabbitmq (a general-purpose message broker) as a microservice we would like to integrate into a LSCSDE K8s cluster. This walkthrough will highlight key considerations such as development project structure and repository setup, GitOps management and required configuration settings to integrate a new project within the lscsde codebase.    

### Project Setup
Prior to development, it is important to assess what type of service resources are needed and the requirements such a service will address. In most cases, you will be able to build on an existing service that can be deployed within a k8s cluster through official Helm or git repos. In the case of RabbitMQ (RMQ), we will leverage the official Helm chart that will help to simplify the provision of K8s resources (pods, networking, storage etc) to support a RMQ instance. Therefore, in most cases, the development of a lscsde service would primarily focus on creating the nessasary workflow to install and configure base resources along with the extension of such services through further adaptations (i.e. kustomizations). To enable this, the lscsde utilises a declarative GitOps approach for infrastructure and application management and utilises FluxCD to manage the deployment and state of microservices within a cluster. Therefore, first, we need to create a git repository that contains the nessasary fluxCD configuration detail for our RMQ microservice and can allow the project to be associated with the primary lscsde flux configuration and helm repositories. To do this:

1. Go to the [LSCSDE project](https://github.com/lsc-sde) and create a public git repository (see [here](https://github.com/lsc-sde/iac-flux-rabbitmq) for the example RMQ flux configuration repo)
2. In VSCode, clone the primary [LSCSDE repo](https://github.com/lsc-sde/lsc-sde) that links together all component/service repos of the lsscde framework
3. Add your service repo (in this example, the repo just created named iac-flux-rabbitmq) as a submodule in the 'iac/flux' directory:
  ```bash
  git submodule add https://github.com/lsc-sde/iac-flux-rabbitmq iac/flux/iac-flux-rabbitmq
  git submodule update --init --recursive
  ```
4. Note, iac/flux is the current placeholder for flux configuration repositories. However, this may change over time. Track the discussion on submodule structuring for flux, docker, helm and terraform [here](https://github.com/lsc-sde/lsc-sde/issues/62).

5. Each developed component must follow a release strategy that ensures new versions are packaged and prepared on a release branch that uses a semantic version (semver) approach. To simplify this, the primary lsc-sde repo includes a number of reusable github actions that any microservice flux repository can use to initiate a new release. To do this, add a .github/workflows directory into your repo and include a workflow call similar to the following:
  ```yaml
  name: Create Release Branch from Main

  on:
    workflow_dispatch:
    push:
      branches:
      - 'main'
  jobs:
    package:
      uses: lsc-sde/lsc-sde/.github/workflows/flux-release.yaml@main
      with:
        directory: iac/flux/iac-flux-rabbitmq
        yamlPath: rabbitmq
      secrets: inherit
  ```

Now we have the base of our flux repository associated with the primary lsc-sde repo and supporting github actions for releases we need to define some flux code to perform the installation of the official rabbitmq helm chart along with any additional adaptations we may require. At this point, if your understandng of FluxCD is limited, [go and learn](https://fluxcd.io/flux/concepts/) more before proceeding, specifically the role of the Kustomize and Helm controllers and custom resource definitions (CRDs) (HelmRepsitory, HelmRelease, Kustomization, GitRepository) that run within the target cluster to realise resources specified within a flux configuration repo. In our case, that will be config for initialising RMQ via the 'rabbitmq-cluster-operator' Helm chart from the [bitami](https://charts.bitnami.com/bitnami) helm repository!

In our flux config we define the nessasary yaml to create a HelmRepository object for bitnami and a HelmRelease object that specifies the chart we want to install along with the particular version. See the flux yaml in our example [here](https://github.com/lsc-sde/iac-flux-rabbitmq/tree/main/rabbitmq-base/base) for more detail. However, the HelmRelease yaml should be structured similar to:

```yaml
apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: rabbitmq
  namespace: rabbitmq
  annotations:
    xlscsde.nhs.uk/flux-branch: main
spec:
  targetNamespace: rabbitmq
  releaseName: rabbitmq
  chart:
    spec:
      chart: rabbitmq-cluster-operator
      version: "4.3.19"
      sourceRef:
        kind: HelmRepository
        name: rabbitmq-repo
        namespace: rabbitmq 
  interval: 10s
  install:
    remediation:
      retries: -1
    disableWait: true
    disableWaitForJobs: true
  upgrade:
    remediation:
      retries: -1
    disableWait: true
    disableWaitForJobs: true
```

Ensure that the root of your flux repository and any sub-directories contain the nessasary Kustomization.yaml files to indicate which base and overlay configurations should be applied when flux actualises the service in the cluster. At this point, you should have a flux repository for your service with some working yaml flux can use to prepare and deploy your service into the cluster. It is possible to test the flux code before integrating the microservice into a particular cluster deployment (see below for details) using the devcontainer associated with the primary lsc-sde repository. For more details see [this guide](https://lsc-sde.github.io/lsc-sde/Secure-Data-Environment/Developers/Devcontainer-Guide.html) on the devcontainer.

### GitOps & Cluster Deployment
Now we're ready to associate our service repository with a particular cluster deployment. At present, lscsde deployment is managed through a central [Flux repository](https://github.com/lsc-sde/iac-flux-lscsde) repo along with two helm charts, one for provisioning the [components/microservices](https://github.com/lsc-sde/iac-helm-lscsde-flux) that make up the SDE and another for provisioning related k8s [namespaces](https://github.com/lsc-sde/iac-helm-lscsde-namespaces).

To integrate and test a microservice within the lscsde framework, these repositories require several modifications so that the flux configuration repository you've created for your microservice is included and provisioned when deployed to a particular cluster. As highlighted previously, some of this configuration can be handled by the flux (i.e. [flux-release.yaml](https://github.com/lsc-sde/lsc-sde/blob/main/.github/workflows/flux-release.yaml)) and helm (i.e.[helm-release.yaml](https://github.com/lsc-sde/lsc-sde/blob/main/.github/workflows/helm-release.yaml)) release github workflows defined in the primary [lsc-sde repository](https://github.com/lsc-sde/lsc-sde). However, such automated configurations are only applied on the main branch of the central flux and helm repositories. If for example, we first want to test our service within an lscsde deployment running on a dev or staging cluster we need to apply changes directly on the relevant deployment branch (e.g. 'dev' for the dev cluster deployment) on each of the central flux and helm repositories.

#### LSCSDE Flux
To integrate your service flux configuration into the development cluster:
1. Checkout the [central flux configuration repository](https://github.com/lsc-sde/iac-flux-lscsde) 'dev' branch
2. Edit/ensure the core/flux-config.yaml file includes a reference to your component that is similar to:
```yaml
  rabbitmq:
    repository:
      branch: release/0.1.18
```   
This configuration tells flux which branch of your flux configuration git repository to use for deployment. Once deployed, it's possible to confirm the correct branch is in use on the chosen development k8s cluster by running:
```bash
kubectl get gitrepository -n lscsde-config
```
3. In a few steps time you will also modify the lscsde namespaces helm chart. To ensure the flux config is using the latest version of that chart, you will need to edit the [core/release-namespaces.yaml](https://github.com/lsc-sde/iac-flux-lscsde/blob/main/core/release-namespaces.yaml) file here:
```yaml
spec:
  targetNamespace: lscsde-config
  releaseName: lscsde-namespaces
  chart:
    spec:
      chart: lscsde-namespaces
      version: 0.1.11
```

It is also possible to specify helm chart versions to be used in the core/helm-config,yaml. In both cases, these config files are used to create ConfigMap objects to support the configuration of subsequent flux repositories.

#### LSCSDE Helm
The central lscsde helm chart primarily specifies the components which should be deployed and the associated configuration properties for each. To add your new service, you must do the following:
 1. Checkout the [central flux helm repo](https://github.com/lsc-sde/iac-helm-lscsde-flux) on main branch (Note: we may want to establish a similar branching strategy to the flux-lscsde repo in future)
 2. Under the templates/ directory edit **deployment-configuration.yaml** to set up your services chart version and repo branch config variables specified in the values.yaml, for example:

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

#### LSCSDE Helm Namespaces
In the [lscsde helm library namespaces](https://github.com/lsc-sde/iac-helm-lscsde-namespaces) repo edit the values.yaml to include your component similar to:
```yaml
  rabbitmq:
    state: "enabled"
    namespace: rabbitmq
    injectCertificates: true
```

This specifies whether the associated K8s namespace your service relies on should be enabled. 

At this point, all the required flux and helm repository configuration should be in place for Flux to reconcile the changes and provision your service in the target cluster. In this example, we have targeted the lscsde dev cluster on running on AKS. It can take a few minutes for changes in git to be reflected in the cluster. However, you can debug and verify your service git repo and kustomizations have deployed successfully through various kubectl commands e.g.:
```bash
  kubectl get gitrepository -n lscsde-config
  kubectl get kustomizations -n rabbitmq
  kubectl get pods -n rabbitmq
```

### Further Reading

* Extend your service to support [Public Access & TLS via Secrets Distributor]()
* Learn how to integrate your service with the [LSCSDE's Security & Authentication Service (Keycloak)]()