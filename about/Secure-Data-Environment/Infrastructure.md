# Infrastructure
The Lancashire and South Cumbria Secure Data Environment is designed primarily to run on a Azure Kubernetes Environment, however we maintain the principles that the core solution should be able to run on any kubernetes cluster, even a bare metal implementations. Any components specific to azure (such as the AKS DNS Operator) should be interchangeable with equivalent components for other cloud solutions providers if someone would like to contribute an AWS, GCP or other version.

The solution is provisioned entirely via [Infrastructure as code](./Infrastructure/IAC.md)