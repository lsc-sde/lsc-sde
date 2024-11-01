---
title: Analytics Workspaces
layout: page
nav_exclude: true
---

# Analytics Workspaces
An analytics workspace defines all the elements of an analytics workspaces so that Kubernetes and JupyterHub can provision these workspaces as required.

## Custom Resource Definition
The Lancashire and South Cumbria Secure Data Environment (LSC-SDE) [Analytics Workspace Management Solution](../../Analytics-Workspace-Management-Solution.md) (AWMS) leverages [Kubernetes Custom Resource Definitions](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/) to store and manage workspaces

Example:
```yaml
apiVersion: xlscsde.nhs.uk/v1
kind: AnalyticsWorkspace
metadata:
  name: example-workspace
  namespace: jupyterhub
spec:
  displayName: Example Workspace
  description: |-
    An example workspace I've created in order to facilitate testing of the management portal.

    There may be numerous of these on local environments.
  jupyterWorkspace:
    extraLabels:
      xlscsde.nhs.uk/test: IsTestWorkspace
    image: lscsde/datascience-notebook-default:0.1.0
    persistentVolumeClaim: {}
    resources:
      limits:
        cpu: 2
  validity:
    availableFrom: "2022-01-03"
    expires: "2030-01-07"
```

## Schema Definition
The full schema definition can be found on the [Helm Repository](https://github.com/lsc-sde/iac-helm-analytics-workspace-management/blob/main/templates/AnalyticsWorkspace.yaml)