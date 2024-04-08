# Docker Images
The following are custom docker images made for the SDE solution

## OHDSI
[The Observational Health Data Sciences and Informatics](https://www.ohdsi.org/)  (or OHDSI, pronounced "Odyssey") program is a multi-stakeholder, interdisciplinary collaborative to bring out the value of health data through large-scale analytics. All our solutions are open-source.

We utilise a number of customised docker images for our implemenetation of the OHDSI platform.

* [Atlas](https://github.com/lsc-sde/docker-ohdsi-atlas)
* [Hades](https://github.com/lsc-sde/docker-ohdsi-hades)
* [WebAPI](https://github.com/lsc-sde/docker-ohdsi-webapi/)

We do try to contribute back into the OHDSI main projects where possible also in order to ensure that others in the community gain the benefits of our changes

## Jupyter Hub
The Lancashire and South Cumbria Secure Data Environment uses a [customised version of the Jupyter Hub container](https://github.com/lsc-sde/docker-jupyterhub) that allows us to integrate workspace management capabilities which are embedded into the kubernetes control plane. This is supported by a [management portal](https://github.com/lsc-sde/docker-analytics-workspace-mgmt) that allows us to manage workspaces and membership to those workspaces giving us the ability to customise workspaces to individual needs of the analysis teams.

### Jupyter Data Science Images
* [datascience-notebook](https://github.com/lsc-sde/docker-datascience-notebook/) - The default notebook used by jupyterhub 

## VNC Clients
In order to facilitate secure external access to the tools, we are currently implementing a [docker image that creates a custom desktop that provides only access to a secured browser which can be used to access the relevant jupyter workspace as required by the user](https://github.com/lsc-sde/docker-analytics-vnc-client).


This client will be exposed by our implementation of [Apache Guacamole](https://github.com/lsc-sde/iac-helm-guacamole).

## LSC SDE Operators
* [AKS DNS Operator](https://github.com/lsc-sde/docker-aks-dns-operator/)
* [Secrets Distributor](https://github.com/lsc-sde/docker-secrets-distributor)
* [ConfigMap Transformer](https://github.com/lsc-sde/docker-configmap-transformer-controller) - Deprecated