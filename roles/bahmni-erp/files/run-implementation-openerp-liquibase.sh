#!/bin/sh
set -e -x
. /etc/bahmni-installer/bahmni.conf

CHANGE_LOG_TABLE="-Dliquibase.databaseChangeLogTableName=databasechangelog -Dliquibase.databaseChangeLogLockTableName=databasechangeloglock"
LIQUIBASE_JAR="/opt/bahmni-erp-connect/bahmni-erp-connect/WEB-INF/lib/liquibase-core-2.0.3.jar"
DRIVER="org.postgresql.Driver"
CHANGE_LOG_FILE="/var/www/bahmni_config/openerp/migrations/liquibase.xml"
CLASSPATH="/etc/bahmni-erp-connect/openerp-atomfeed-service.war"

if [  -f "$CHANGE_LOG_FILE" ]
then
java $CHANGE_LOG_TABLE -jar $LIQUIBASE_JAR --classpath=$CLASSPATH --driver=$DRIVER --changeLogFile=$CHANGE_LOG_FILE --defaultSchemaName=openerp --url=jdbc:postgresql://$OPENERP_DB_SERVER:5432/openerp --username=$OPENERP_DB_USERNAME --password=$OPENERP_DB_PASSWORD update
fi
