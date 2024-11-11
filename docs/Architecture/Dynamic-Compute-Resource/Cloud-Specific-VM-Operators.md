---
title: Cloud Specific VM Operators
parent: Dynamic Compute Resource
grand_parent: Architecture
layout: page
---

Another option for provisioning compute resource would be to define a virtual machine definition. This virtual machine could be automatically provisioned by kubernetes and connected to a predefined virtual network infrastructure suitable to the cloud provider in question.

While the virtual machine definitions might largely be the same, certain things will need to be configured per cloud provider, as such the definition may not be completely generic for use on different cloud providers. That said, in theory you could have multiple different versions of the operator running on the same cluster for numerous different cloud providers, accounts and subscriptions to give you the maximum amount of flexibility over the solution.

While this isn't the recommended solution for dynamic compute resource, this would give a great deal of flexibility and capabilities within the system. As a result it should be considered as a future improvement for the solution.

## Special Note
This capability is theoretical and a space has been left for it in the solution design, however it is yet to be implemented.
