---
title: Architecture
layout: page
has_children: true
has_toc: false
---

# Solution Architecture
The following outlines a high level architecture of the solutions application layer.


![Architecture](./Architecture/SDE.png)

## Functional Requirements
The application layer consists of a number of core functional requirements

### Compute Resource
The solution must provide be capable of providing secure compute capabilities to researchers, this compute resource should be highly flexible in order to allow us to provide capabilities to specialised compute resources where needed. 

### OMOP Analysis
The solution must provide out-of-the-box OMOP analysis capabilities. It should be able to leverage it through libraries on the compute resource, or be presented through a queryable User Interface.

### Federated Analytics
The solution must be capable of responding to federated analysis made by external TRE's and SDE's.

### Workspace Isolation
The solution must enforce that workspaces are kept separate to ensure that data cannot be moved from one workspace to another. Data should be stored in separated logical containers on the infrastructure for the same reason.

### Externally Accessible
The solution should be accessible from any location without the need for specialist software or tools to be installed on to the client machine. The solution for connecting into the solution should be secure, auditable and must enforce workspace isolation at all times.

### Multi-cluster offloading
The solution should be capable of offloading work to another cluster, allowing it to leverage the capabilities available at each location. For example the solution might run primarily on cloud, but want to be able to offload work to a machine that is running on-premise because the data that it needs is closer to that location, or because it has specialised GPU or CPU resources which might be best suited to the job at hand.

### Usage and Cost management
The solution should be capable of tracking the usage of the solution and each individual workspace and therefore calculate the cost of each workspace so that it might be charged back to a relevant project.

### Secure Import and Export
The solution must provide capabilities for secure import of data into the environment as well as secure egress from the environment. This may require a variety of different patterns to account for secure ingress and egress in a number of different scenarios, such as automated ingress, automated egress, manual ingress, manual egress.

## Non-functional requirements
The application layer also consists of a number of core non-functional requirements

### Highly Secure
Any solution given to the research engineers using this system will need to be tightly controlled. This control however will also need to be balanced against the needs of developers to have the flexibility to do what they need to do within the environment. 

### Highly Portable
The solution's core capabilities should be largely capable of running on any cloud provider, or on-premise. While some capabilities may not be available at all locations, core capabilities should be able to theoretically run anywhere.

#### Special Caveat
Primary focus on the solution should be that the solution should be able to run on Azure and on-premise because these are the environments that we will have. However designs should account for swappable components that can make the solution capable of running on cloud providers at a later date.

### Ease of development
The solution should be as easy and cheap to develop as possible, as a result, the core capabilities should be able to run on a local development environment without needing any specialised development environments or cloud subscriptions just to get started.

### Easily useable
The solution should make it as easy for researchers to get started on as possible, many other such environments currently require the research engineers to install specialised software onto their clients, or require them to fire up containers, open ports, etc when they are logged into their VDI. This not only adds complexity for the users, it can open up risks in the solution which are harder to account for. 

### Easily deployable
The solution should be as easy to deploy into a new environment as possible with minimal user interaction to get started.

### Highly Configurable
The solution should be highly configurable, allowing the person deploying it to be able to switch out components, disable them and add new ones as needed.

### Highly Scalable
The solution should where possible, be highly scalable, allowing the system to leverage the elasticity of any cloud provider it may be capable of running on.

### Highly available
The solution should be capable of running in a highly available environment, so that it is resilient to hardware faults. 

### Community driven
The solution should encourage community engagement, to allow others to not only use the solution, but to contribute to its ongoing development.

## The solution
Based upon the functional and non-functional requirements the solution proposed is as outlined below:

### Microservices 
To satify the criteria for portability and high degree of flexibilty demanded, the solution should implement a microservices architecture. This will allow us to:
* Swap in and out components as needed for the implementing organisation
* Enable and disable components as needed for the implementing organisation
* Add in new capabilities easily
* Ensure the maximum portability for the solution

### Containerised Applications and Services
To satisfy the high portability requirements, the solution will implement containerised applications and services, these services should, where possible compile on a variety of architectures, to allow the services to run on the widest variety of equipment. This will also ensure that: 
* Each component can run independently of each other
* Each component is self-contained with any prerequisite libraries
* Each component is as portable as possible.

### Kubernetes
To leverage the abilities of the a microservices, we will need to orchestrate the containers so that they run at the right time and place. While there are a number of solutions available to do this, kubernetes is an obvious choice in this instance as it not only provides:
* The ability to deploy containers in a controlled manner
* High degree of portability due to the many different providers supplying PaaS offerings of kubernetes, but also a variety of different solutions for hosting kubernetes on on-premise hardware.
* Abilities via CNI's and CSI's to dynamically provision storage and networking as required

But it also provides a pattern for easily creating [operator](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/)components that we can leverage in our design to manage workspaces, etc.

### Open Source 
To maximise community engagement, we will create open source components and should leverage open source components that already exist in our solution. Where these existing components do not meet our requirements, we should look to extend these, or where suitable contribute back into their projects. By engaging with the communities involved in contributing into these components we may also find that those communities will take more interest in our own solution and will look to leverage and contribute to it.

### Infrastructure-as-code
To ensure maximum repeatability and consistency, we will leverage infrastructure-as-code (IAC) to deploy the infrastructure on our estate. For consistency we will use the following technologies and languages:

#### Terraform
Terraform will be used to provision any original cloud infrastructure, where possible this should also deploy FluxCD into the kubernetes cluster once it is provisioned.

#### FluxCD
FluxCD will allow us to utilise a gitops methodology to deploy our applications and services into our kubernetes cluster and ensure that they remain consistent. This will utilise the kustomization capabilities to target a specific tag or branch.

#### Helm Charts
Helm charts will be used to deploy any applications and services for deployment into our environments.

### Core Solution Areas
#### Analytics Tools
The solution will [provide a number of analytics tools](./Architecture/Analytics-Tools.md) for visualising and querying data such as OMOP datasets used within the research workspaces. 

#### Workspace Management Services
The [Analytics workspace management solution](./Architecture/Workspace-Management-Services.md) (AWMS) will work alongside the dynamic compute resource and other aspects of the system to provide isolated workspaces.

#### Dynamic Compute Resource
Dynamic compute resource can be provided using a number of different methodologies such as [Jupyter Hub](./Architecture/Dynamic-Compute-Resource/Jupyter-Hub.md) or [Cloud Specific VM Operators](./Architecture/Dynamic-Compute-Resource/Cloud-Specific-VM-Operators.md)

#### Identity and access management
The solution will provide a generic and flexible base for [identity and access management](./Architecture/Identity-and-Access-Management.md) to be supported by all applications running on the solution. 

#### Virtual Desktop Infrastructure (VDI)
The solution will provide for virtual desktop infrastructure via the use of external tools. [Apache Guacamole](./Architecture/Virtual-Desktop-Infrastructure/Apache-Guacamole.md) is the recommended solution, however other solutions can be swapped out if preferred.

#### Airlock
The solution will provide a collection of services that will provide for secure ingress and egress from the environment, these [airlock services](./Architecture/Airlock-Services.md) will provide capabilities for:

* Automated Ingress from a variety of source systems
* Manual Ingress for bring-your-own-data scenarios
* Automated Egress to predefined destination systems
* Manual Egress of data

In each case, the solution will provide a number of gates for the approval of data before it can be either ingressed or egressed from the environment.

#### Supporting Services
The solution will utilise a number of supporting services to help the solution function correctly

### Solution Management
To allow for easy management of the solution, a layer is needed to provide the tools necessary to allow administrators to monitor the solution and make changes as required.

#### Management Portal
The solution should provide a management portal to allow administrators to maintain the various Workspaces, Data Sources and Bindings that make up the system.

#### Reporting and Analytics
The solution provides a platform for reporting and analytics of the solution, this solution could also be used to expose data resulting from research analytics performed on the environment. However any such data will need to go through the same rigorous review as those otherwise exported by the solution
