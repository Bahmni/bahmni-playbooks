#!/bin/bash

. /etc/bahmni-installer/bahmni.conf

RESULT_USER=`psql -U postgres -h$OPENELIS_DB_SERVER -tAc "SELECT count(*) FROM pg_roles WHERE rolname='clinlims';"`
RESULT_DB=`psql -U postgres -h$OPENELIS_DB_SERVER -tAc "SELECT count(*) from pg_catalog.pg_database where datname='clinlims';"`

if [ "$RESULT_USER" == "0" ]; then
    echo "creating postgres user - clinlims with roles CREATEDB,NOCREATEROLE,SUPERUSER,REPLICATION"
    createuser -Upostgres  -h$OPENELIS_DB_SERVER -d -R -s --replication clinlims;
fi

if [ "$RESULT_DB" == "0" ]; then
    createdb -Upostgres -h$OPENELIS_DB_SERVER clinlims;
    psql -Uclinlims -h$OPENELIS_DB_SERVER clinlims < '/etc/bahmni-installer/deployment-artifacts/openelis_backup.sql'
fi
