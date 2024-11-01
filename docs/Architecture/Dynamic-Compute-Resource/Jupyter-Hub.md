---
title: Jupyter Hub
parent: Dynamic Compute Resource
grand_parent: Architecture
layout: page
---

Jupyter Hub, along with kubespawner, provides a way of provisioning dynamic jupyter notebooks, these notebooks provide a convenient way and user interface for being able to provide developers with compute resources.

This will be the recommended metholodology for providing dynamic compute resource as it provides the most flexibility and the quickest methodology for rapid provisioning dynamic resource in a stable and consistent manner.

By leveraging autoscale capabitilies offered by the various cloud providers, kubernetes will be able to provision new nodes dynamically as required to cope with demands.
