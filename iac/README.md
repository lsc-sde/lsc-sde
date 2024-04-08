# Infrastructure
The Lancashire and South Cumbria Secure Data Environment is designed primarily to run on a Azure Kubernetes Environment, however we maintain the principles that the core solution should be able to run on any kubernetes cluster, even a bare metal implementations. Any components specific to azure (such as the AKS DNS Operator) should be interchangeable with equivalent components for other cloud solutions providers if someone would like to contribute an AWS, GCP or other version.




## Infrastructure as Code
IaC for the LSCSDE is split into 3 core types:
* [Helm Charts](./helm/)
* [Flux Charts](./flux/)
* [Terraform](https://github.com/lsc-sde/k8s-iac)


## Container Images
The solution relies heavily on kubernetes and as a result builds docker images to:
* [Docker Images](../docker/)
