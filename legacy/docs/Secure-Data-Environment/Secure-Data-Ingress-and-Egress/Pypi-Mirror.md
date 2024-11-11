---
title: PyPi Mirror
layout: page
parent: Secure Data Ingress and Egress
---

# PyPI Mirror
When a workspace is defined, a pypi mirror should be implemented that will download any defined modules and their dependencies. Jupyter servers will then fetch any dependencies from this mirror rather than pypi.org direct.

```mermaid
flowchart LR
    UserVDI((User VDI)) --> MP(Management Portal)
    MP -->|Define Forks| KubeAPI
    MP -->|Request Push| KubeAPI

    UserVDI --> JupyterHub(Jupyter Hub)
    JupyterHub --> JupyterInstance(Jupyter Instance)
    JupyterInstance -->|Download Packages| pm[(PIP Mirror)]

    KubeAPI --> |Watches PipEvents| PipOperator[/PIP Operator/] 

    PipOperator --> |Download Packages|pypi[(Pypi.org)]
    PipOperator --> |Upload Packages|pm
```