#!/bin/bash

if [ -e smile.sql ]; then
rm -f smile.sql
fi

touch smile.sql

echo "drop user csmiles cascade;
create user csmiles identified by smiles;
grant IMP_FULL_DATABASE to csmiles;
ALTER USER csmiles QUOTA UNLIMITED ON USERS;
grant connect, resource to csmiles;
create or replace directory dumps as '/opt/dev/projects/github/dumps';
grant read, write on directory dumps to csmiles;" >> smile.sql

echo exit | sqlplus system/liferay123 @smile.sql

impdp system/liferay123@//localhost/oracl dumpfile=Portal_01.dmp,Portal_02.dmp,Portal_03.dmp,Portal_04.dmp directory=dumps logfile=smiles.log remap_tablespace=TS_PORTAL:USERS remap_schema=PORTAL:csmiles