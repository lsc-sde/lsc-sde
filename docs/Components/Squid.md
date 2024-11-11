---
title: Squid
layout: page
parent: Components
has_children: true
---

# Squid
[Squid](https://www.squid-cache.org/) is a forward proxy server with caching capabilities and native support for TLS. 

While a forward proxy might seem an antiquated solution for network traffic and in usual circumstances we might prefer a proper firewall solution and routing, we do not need anything so complicated for what we are doing here.

The Squid proxy is used by workspace virtual machines to access resources such as Jupyter hub. This allows us to control what the workspace virtual machine can access via network policies, allowing us to restrict the virtual machine to only be able to access the specific workspaces we want them to access.