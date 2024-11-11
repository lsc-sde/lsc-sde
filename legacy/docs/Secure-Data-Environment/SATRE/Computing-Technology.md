---
title: Computing technology and Information Security
layout: page
parent: SATRE
nav_order: 2
nav_exclude: true
---

# Computing technology and Information Security
This page will outline how the Secure Data Environment addresses the concerns of Computing technology and Information Security as outlined in the SATRE specification.

https://satre-specification.readthedocs.io/en/stable/pillars/computing_technology.html

## End User Computing
### Computing Interfaces
TODO: Write up how the SDE helps system builders address the concerns of end-user computing computing interfaces via the use of Apache Guacamole, Restricted Browsers and Jupyter Hub.

### Software Tools
TODO: Write up how the SDE helps system builders address the concerns of end user software tools via the use of Apache Guacamole, restricted browsers and Jupyter Hub. As well as how security patching etc is due to

### Code Version
TODO: Write up how the SDE helps system builders and developers by providing version control systems - to be implemented

## Artefact Management 
TODO: Write up how the SDE helps system builders and developers by providing appropriate package mirrors - to be implemented

## Advanced Computing
TODO: Write up how the SDE helps system builders and developers by providing on-demand access to advanced compute capabilities such as GPU resources and how this remains separated from other projects.

## Infrastructure Management
### Infrastructure Deployment and Removal
The SDE core infrastructure is deployed primarily through [infrastructure as code](../Infrastructure/IAC.md). This is initially [Terraform](../Infrastructure/IAC/Terraform.md), which in turn calls [FluxCD](../Infrastructure/IAC/FluxCD.md) and [Helm Charts](../Infrastructure/IAC/Helm.md). This allows us to provision and destroy whole environments quickly and easily and makes deployment repeatable, allowing multiple environments to be provisioned as needed to fulfil the organisation's testing and deployment strategy.


### Availability Management
While the solution is capable of being run on a single node, it is designed to ultimately be run on a multi-node kubernetes cluster. This provides a large amount of self-healing capabilities out-of-the-box. When paired with a cloud provider offering disaster recovery capabilities such as availability zones or geo-redundancy capability this can assist the system builder in providing disaster recovery and availability for the implementing organisations allowing them to balance costs with the individual needs of their organisation.

### Network Management
TODO: Add details on how network policies via calico controllers and how other things such as network security groups are setup to help system builders secure the solution on behalf of their organisation. 

### Infrastructure Analytics
TODO: Document how the SDE helps address this.

### Capacity Management
TODO: Add details on how via elastic scalable resources provided by azure and managed by the kubernetes cluster help system builders manage capacity

### Billing Process
TODO: Add details on how via elastic scalable resources provided by azure and managed by the kubernetes cluster help system builders manage costs.
