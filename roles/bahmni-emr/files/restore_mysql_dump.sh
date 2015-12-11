#!/bin/sh
set -e -x
. /etc/bahmni-installer/bahmni.conf

RESULT=`mysql -h $OPENMRS_DB_SERVER -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD --skip-column-names -e "SHOW DATABASES LIKE 'openmrs'"`
if [ "$RESULT" != "openmrs" ] ; then
    echo "openmrs database not found... Restoring a base dump"
    mysql -h $OPENMRS_DB_SERVER -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD < '/etc/bahmni-installer/deployment-artifacts/mysql_dump.sql'
fi

