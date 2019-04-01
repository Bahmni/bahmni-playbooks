#!/bin/bash

. /etc/bahmni-installer/bahmni.conf

RESULT_USER=`psql -U postgres -h$OPENERP_DB_SERVER -tAc "SELECT count(*) FROM pg_roles WHERE rolname='openerp';"`
RESULT_DB=`psql -U postgres -h$OPENERP_DB_SERVER -tAc "SELECT count(*) from pg_catalog.pg_database where datname='openerp';"`

if [ "$RESULT_USER" == "0" ]; then
    echo "creating postgres user - openerp with roles CREATEDB,NOCREATEROLE,SUPERUSER,REPLICATION"
    createuser -Upostgres  -h$OPENERP_DB_SERVER -d -R -s --replication openerp;
fi

if [ "$RESULT_DB" == "0" ]; then
    createdb -Uopenerp -h$OPENERP_DB_SERVER openerp;
    psql -Uopenerp -h$OPENERP_DB_SERVER openerp < '/etc/bahmni-installer/deployment-artifacts/openerp_backup.sql'
fi
