create schema webapi_security;

DROP TABLE IF EXISTS webapi_security.security;

CREATE TABLE webapi_security.security
(
    email character varying(255),
    password character varying(255)
);

-- use this web site (with default 10 rounds) to bcrypt encrypt passwords: https://www.browserling.com/tools/bcrypt

-- admin user: userid = 'admin', password = 'admin'
--insert into webapi_security.security (email,password)
insert into webapi_security.security (email,password)
values ('admin', '$2a$10$opEKwT32fEvoPfSbzE1Rx.p8QsCG0KryiA7VEguLP/V0M62aho6mC');

-- ohdsi user: userid = 'ohdsi', password = 'ohdsi'
insert into webapi_security.security (email,password)
values ('ohdsi', '$2a$04$Fg8TEiD2u/xnDzaUQFyiP.uoDu4Do/tsYkTUCWNV0zTCW3HgnbJjO');

