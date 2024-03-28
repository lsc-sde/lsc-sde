The flux configurations used by the SDE environment

# Core Configurations
* [lscsde](./lscsde/)
* [keda](./keda/)
* [certmanager](./certmanager/)
* [nginx](./nginx/)

# Application Configurations
* [Analytics Workspace Management](./analytics-workspace-management/)
* [Jupyter Hub](./jupyter/)
* [Prefect Server](./prefect-server/)
* [OHDSI](./ohdsi/)
* [Keycloak](./keycloak/) - deprecated

# Utility Configurations
* [Github Action Runners](./github-action-runners/)

The core flux configuration to call is the [lscsde flux configuration](./lscsde/), this will cascade create all of the other helm releases and flux configurations.