---
title: AnalyticsWorkspaceDataBindings
parent: Custom Resources
layout: page
grand_parent: Developer Guide
nav_order: 4
---

An AnalyticsWorkspaceDataBinding resource binds a [AnalyticsWorkspaceDataSource](./AnalyticsWorkspaceDataSources.md) to an [AnalyticsWorkspace](./AnalyticsWorkspaces.md).

```yaml
apiVersion: xlscsde.nhs.uk/v1
kind: AnalyticsWorkspaceDataBinding
metadata:
  name: dsb-782b4a1f07234229980f75f2f651412a
spec:
  workspace: advanced-generic-workspace
  datasource: ds-782b4a1f07234229980f75f2f651412a
```
