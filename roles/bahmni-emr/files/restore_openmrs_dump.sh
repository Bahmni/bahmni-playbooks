#!/bin/sh
set -e -x
. /etc/bahmni-installer/bahmni.conf

RESULT=`mysql -h $OPENMRS_DB_SERVER -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD --skip-column-names -e "SHOW DATABASES LIKE 'openmrs'"`
if [ "$RESULT" != "openmrs" ] ; then
    echo "openmrs database not found... Restoring a base dump"
    mysql -h $OPENMRS_DB_SERVER -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE openmrs;"
    mysql -h $OPENMRS_DB_SERVER -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD openmrs < '/etc/bahmni-installer/deployment-artifacts/openmrs_backup.sql'
fi

