# Apache Guacamole
[Apache Guacamole](https://guacamole.apache.org/) is a clientless remote desktop gateway. It supports standard protocols like VNC, RDP, and SSH.

## Database
The Lancashire and South Cumbria Secure Data Environment uses an external postgresql server to provide RDBMS functionality to the application. In a cloud environment it is expected that this will be a managed postgresql server for these such as:
* [Azure Database for Postgresql Server](../Infrastructure/Elastic-Compute-Resource/Microsoft-Azure/Postgresql-Server.md)

In a baremetal environment it is expected that you would install the database on a seperate server, however you can install locally if needed, but this is not provided for in the implementation at present.

## Development
The following repositories relate to our implementation of this component:
* [Helm Chart](https://github.com/lsc-sde/iac-helm-guacamole)