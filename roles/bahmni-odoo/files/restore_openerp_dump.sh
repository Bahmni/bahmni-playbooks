#!/bin/bash

. /etc/bahmni-installer/bahmni.conf

RESULT_USER=`psql -U postgres -h$OPENERP_DB_SERVER -tAc "SELECT count(*) FROM pg_roles WHERE rolname='odoo';"`
RESULT_DB=`psql -U postgres -h$OPENERP_DB_SERVER -tAc "SELECT count(*) from pg_catalog.pg_database where datname='odoo';"`

if [ "$RESULT_USER" == "0" ]; then
    echo "creating postgres user - odoo with roles CREATEDB,NOCREATEROLE,SUPERUSER,REPLICATION"
    createuser -Upostgres  -h$OPENERP_DB_SERVER -d -R -s --replication odoo;
fi

if [ "$RESULT_DB" == "0" ]; then
    createdb -Uodoo -h$OPENERP_DB_SERVER odoo;
    psql -Uodoo -h$OPENERP_DB_SERVER odoo < '/etc/bahmni-installer/deployment-artifacts/odoo_backup.sql'
fi
