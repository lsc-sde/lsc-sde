---
title: Networking
parent: Security
grand_parent: Systems Administrators Guide
layout: page
---


## Network Policies
The solution should impose a [strict network policies](../../Architecture/Supporting-Services/Calico.md) allowing traffic only to services that need it. 

## Encryption In Transit
All network traffic within the system uses encryption in transit via TLS v1.2, certificates are issued within the solution. It is recommended that when implementing the solution, that you place the public endpoints of the solution behind a Web Application Firewall to further protect the system.