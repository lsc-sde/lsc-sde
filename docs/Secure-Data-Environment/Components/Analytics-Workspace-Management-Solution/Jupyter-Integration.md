# Jupyter Hub Integration
The Lancashire and South Cumbria Secure Data Environment (LSC-SDE) [Analytics Workspace Management Solution](../Analytics-Workspace-Management-Solution.md) (AWMS) integrates with [JupyterHub](https://jupyter.org/hub) in order to allow easy management of Analytics workspaces in Jupyter Hub. 

This utilises a [customised docker image of jupyter hub](https://github.com/lsc-sde/docker-jupyterhub) that hooks up the kubespawner to the [workspace management python libraries](https://github.com/lsc-sde/py-lscsde-workspace-mgmt). These libraries utilise [kubernetes custom resources](../../Kubernetes/Custom-Resource-Definitions.md) which define how a [workspace](../Analytics-Workspace-Management-Solution/Resources/Analytics-Workspaces.md) is configured and who can access it via [bindings](../Analytics-Workspace-Management-Solution/Resources/Analytics-Workspace-Bindings.md)

```mermaid
flowchart LR
 User --> AWMS
 User --> JupyterHub
 AWMS(Analytics Workspace Management Solution) --> |Manage Workspaces and Bindings | KubernetesAPI
 JupyterHub(Jupyter Hub) -->|1. Get Workspace Bindings for User| KubernetesAPI(Kubernetes API)
 JupyterHub --> |2. Get Workspace Definitions| KubernetesAPI 
 JupyterHub -->|3. Provision Notebook| JupyterNotebook(Jupyter Notebook)

```

## Development
* [Python Module - Workspace Management](https://github.com/lsc-sde/py-lscsde-workspace-mgmt)
* [Docker Image - Customised Jupyter Hub](https://github.com/lsc-sde/docker-jupyterhub)
