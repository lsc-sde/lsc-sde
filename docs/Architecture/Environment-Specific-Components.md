---
title: Environment Specific Components
parent: Architecture
layout: page
has_children: true
---

As this solution can run on many different types of hardware supported by many different cloud providers, etc some components will be specific to where the solution is deployed. Some of these components will be internal to kubernetes and specific to the kubernetes implementation that has been created and where it has been deployed, and others will be part of the solution itself.

## CSI Drivers
Kubernetes implements a variety of [Container Storage Interface (CSI) Drivers](https://kubernetes-csi.github.io/docs/) which allows kubernetes to mount storage into a container from a variety of sources. Most cloud 