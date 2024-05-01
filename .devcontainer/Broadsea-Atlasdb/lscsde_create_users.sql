CREATE DATABASE ohdsi;
--CREATE USER "ohdsi@cluster.lsc-sde.local" WITH PASSWORD 'ohdsi';
CREATE ROLE "ohdsi@cluster.lsc-sde.local" WITH SUPERUSER CREATEDB LOGIN PASSWORD 'ohdsi';
--GRANT ALL PRIVILEGES ON DATABASE postgres TO 'ohdsi@cluster.lsc-sde.local';
--GRANT ALL PRIVILEGES ON DATABASE ohdsi TO 'ohdsi@cluster.lsc-sde.local';
--GRANT ALL PRIVILEGES ON DATABASE ohdsi TO postgres;