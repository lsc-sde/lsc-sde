---
title: Secure Data Ingress and Egress
layout: page
has_children: true
has_toc: false
---

# Secure Data Ingress and Egress
The Lancashire and South Cumbria Secure Data Environment implements a secure data ingress and egress capability to ensure that data can be easily imported into the environment while ensuring that data can only be taken out of the environment through secure routes.

In theory, any data should be allowed into the environment while data egress should be tightly controlled, via firewall rules, however due to the nature of TCP/IP networking any allowed ingress point could also be used as an egress port. Once a port is opened data can be streamed outward just as easily as inbound. Many solutions use this as a way of getting around inbound firewall rules and this is the basic premise used by the majority of trojans and other malicious code.

If therefore, a user is given access to github.com, they can use it to access source code, but they could also potentially upload data from the secure data environment into another repository. Likewise someone could use a module website such as pypi.org to potentially upload malicious code. As a result is is important that we control where data can be imported from.

As a result of these issues we recommend that traffic should be tightly controlled with **no direct access to the outside world** ensuring that the only way that data can get in and out of the environment is in a controlled manner.

## Using mirrors
Mirrors are products which download copies of data from other sites on the internet and make them available to the user. These mirrors should target specific data only. If a user is able to upload data into the mirror, this mirror is not available on the internet.
* [Git Server](./Secure-Data-Ingress-and-Egress/Git-Server.md)
* [Pypi Mirror](./Secure-Data-Ingress-and-Egress/Pypi-Mirror.md)
