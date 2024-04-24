# Broadsea-atlasdb

This container is part of the OHDSI Broadsea 2.0 set of Docker containers.
 
A Postgres database in a Docker container pre-configured with OHDSI Atlas/WebAPI application schema tables and loaded with a demo CDM containing synthetic patient data (Eunomia) 
It also contains a very simple demo concept set & cohort definition. See the OHDSI/Eunomia GitHub repo for information about the OHDSI Eunomia sqlite database.

Optional support for Atlas database based security is included with two pre-configured Atlas users:  userid=ohdsi, password=ohdsi and userid=admin, password=admin

This database is intended to be used with the Broadsea-Webtools Atlas/WebAPI Docker container for Atlas application demo/training and for Atlas/WebAPI software unit testing.

See the OHDSI/Broadsea GitHub repo Broadsea 2.0 documentation for instructions and a docker-compose.yml file to start the Atlas application using Broadsea-Webtools with this database container.

## start this postgres database docker container
```bash
docker compose up -d
```

Database userid: postgres
Default password (can be changed in the docker-compose.yml file): mypass


## Postgres database data management

This container uses a docker volume to manage the Postgres data. It will create a new docker volume called atlas-db-postgres-data if it does not already exist.
The Postgres database data will be retained in the docker volume (even if the container is restarted using ddocker-compose down/docker-compose up -d).

To list the docker volumes on the host server use the below command:
```bash
docker volume ls
```

To reset the postgres database data use the below command. Note this command will permanently delete any data changes made to the demo CDM dataset:
```bash
docker volume rm atlasdb-postgres-data
``` 

## postgresql database JDBC connection string - used to connect to this database from a postgresql client

Use 0.0.0.0 as the database host IP address to connect from the local computer where this database container is running (or alternatively use 127.0.0.1),
Otherwise use the IP address of the remote server where the container is running
```text
jdbc:postgresql://0.0.0.0:5432/postgres?user=postgres&password=mypass
```

## build the container - only needed to customize the contents of the database
The preferred approach is to just pull the pre-built Docker container image in Docker Hub.
Below is the command to build the container:
```bash
docker-compose build
```
