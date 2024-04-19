---
title: Creating a New Environment
layout: page
parent: Developer Guide
---
# Provisioning New Environments
Before reading this guide, it is recommended that you first read the [General Developer Guide](../../Developers.md) as this explains the development principles we adhere to on this project.

## Provisioning a New Local Environment in its entirety
The first stage of the deployment relies on the [core flux repository](https://github.com/lsc-sde/iac-flux-lscsde). You can check this out directly, or check it out through the [core repository](https://github.com/lsc-sde/lsc-sde) submodules and will be found at the following path:

```
iac/flux/lscsde
```

### Prerequisites
#### Hardware
There are many components to the LSCSDE so you will minimally need 10GB of **free** memory to run all of the components in a local environment. It is best practice to reserve this memory so that other applications and services on your system do not attempt to use that memory. Running this on an underpowered machine might potentially overload your machine.

For azure users we recommend using a devbox:

https://azure.microsoft.com/en-gb/pricing/details/dev-box/

However, similar offerings are available on other cloud providers and bare metal options are available as well. 

#### PostgreSQL Database
There are a number of prerequisites that you will need in order to make this function:
PostgreSQL Instance - The solution relies on external postgresql server instances rather than running one in cluster. You can setup a postgresql server on your local machine either in a pod of its own or on your local machine directly. Alternatively you can provision a postgres instance elsewhere on your network or on your cloud provider.

#### Kubernetes
##### microk8s
To install locally it is best to use microk8s which can be installed using the following command:

```bash
sudo snap install microk8s
```

Once installed you can setup the required add-ons:

```bash
microk8s enable dns hostpath-storage rbac metallb
```

you will be asked for an IP address range for the service to hand out for the load balancers used by nginx etc, in my instance I used **10.64.140.43-10.64.140.49** however you can use a different range if necessary.

Once all the addon's are installed, you can also setup your local kubectl to work with microk8s (this will overwrite the existing kube config):

```bash
microk8s config > ~/.kube/config
```

##### Docker Desktop
While it is possible to  use docker desktop, there are a number of problems with it which prevent apps from working correctly. The key issue is [a known issue with docker desktop implementation of the kubernetes core DNS service](https://github.com/docker/for-win/issues/13768). This prevents the solution from connecting to addresses on the internet, critically those relating to Microsoft Login. This means that pods will not be able to communicate with Azure Entra ID to allow user login.

#### FluxCD Installation

Once installed, you will need to install the flux CLI:
```bash
curl -s https://fluxcd.io/install.sh | sudo FLUX_VERSION=2.0.0 bash
```

*Please note that on AKS, the flux implementation created by the extensions is not using version 2 of flux, therefore there may be compatibilities issues*

Once the flux CLI is installed, you can then install flux onto the kubernetes cluster
```bash
flux install
```

#### Secrets
You will need to install secrets into a folder on your machine which contains the secrets.

The secrets should be presented as a file per entry with the name, file names are case sensitive.

| Name | What it does |
| --- | --- |
| HadesPassword | Password for the OHDSI Hades system |
| JupyterAppRegistrationClientSecret | The client secret for the app registration used by Jupyterhub |
| OhdsiAppRegistrationClientSecret | The client secret for the app registration used by OHDSI |
| OhdsiDbPassword | The postgresql database server password used to access the OHDSI database |
| JupyterCookieSecret | A 32 byte hex string representing the secret used to encrypt jupyter cookies |
| WildcardCertificate  | The wildcard certificate used for TLS |
| WildcardCertificateKey | The wildcard certificate key used for TLS |
| PrimaryStorageAccountName | The primary storage account name used in azure for storage claims, this can be blank in a local environment |
| PrimaryStorageAccountKey | The primary storage account key used by azure for storage claims, this can be blank in a local environment |
| SqlAdministratorLogin  | The SQL Administrator username, this can be blank in a local environment |
| SqlAdministratorPassword | The SQL Administrator password, this can be blank in a local environment |
| SqlHostName | The SQL Host name, this can be blank in a local environment |
| PatToken | The Personal Access Token used by the github-runners, this can be blank in a local environment |


#### OHDSI Database
You will also need to install or use an existing a postgresql server and setup the ohdsi database. We recommend installing this from scripts in the [Broadsea Atlas DB](https://github.com/OHDSI/Broadsea-Atlasdb/) implementation.

This should be configured to allow connections from the hosts, the /etc/hosts file should be updated to add a record for **cluster.lsc-sde.local** that points at the postgres server.

```
192.168.0.44 cluster.lsc-sde.local # the postgres server
```

This will require a user called **ohdsi@cluster.lsc-sde.local** with permissions to make changes to the ohdsi database

### Installing LSCSDE
Once all of the prerequisites are satisfied you can then install LSCSDE

* Create a fork of the [core flux repository](https://github.com/lsc-sde/iac-flux-lscsde)
* create your own branch on the repository
* create a folder in the ***clusters/*** folder for your environment, this should be unique to your environments kubernetes cluster
* 


#### Configure Flux for LSCSDE
```bash
kubectl create namespace lscsde
kubectl create namespace lscsde-config
flux create source git lscsde --url="https://github.com/your-org-or-user/your-fork-repository" --branch=path/to/your/branch --namespace=lscsde
flux create kustomization lscsde-cluster-config --source="GitRepository/lscsde" --namespace=lscsde --path="./clusters/your-cluster" --interval=1m --prune=true --health-check-timeout=10m --wait=false
```

This should in turn deploy all of the resulting resources on your local cluster.

This will take a few minutes to provision everything, but should largely take care of itself. 

### /etc/hosts file
Once completed you will need to update your /etc/hosts file to include the lsc-sde.local entries:

```
<Your Ingress IP> ohdsi.lsc-sde.local # nginx load balancer
<Your Ingress IP> jupyter.lsc-sde.local # nginx load balancer
<IP of the postgres server> cluster.lsc-sde.local # the postgres server
```
