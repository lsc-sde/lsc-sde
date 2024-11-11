---
title: WebAPI
layout: page
parent: OHDSI
grand_parent: Components
---

# OHDSI WebAPI
[OHDSI WebAPI](https://github.com/OHDSI/WebAPI) contains all OHDSI RESTful services that can be called from OHDSI applications.

## Database
The Lancashire and South Cumbria Secure Data Environment uses an external postgresql server to provide RDBMS functionality to the application. In a cloud environment it is expected that this will be a managed postgresql server for these such as:
* [Azure Database for Postgresql Server](../Infrastructure/Elastic-Compute-Resource/Microsoft-Azure/Postgresql-Server.md)

In a baremetal environment it is expected that you would install the database on a seperate server, however you can install locally if needed, but this is not provided for in the implementation at present.

## Development
The following repositories relate to our implementation of this component:
* [Forked Repository](https://github.com/lsc-sde/fork-ohdsi-webapi)
* [Customised Docker Image](https://github.com/lsc-sde/docker-ohdsi-webapi)