#!/bin/sh
set -e -x
. /etc/bahmni-installer/bahmni.conf

CHANGE_LOG_TABLE="-Dliquibase.databaseChangeLogTableName=databasechangelog -Dliquibase.databaseChangeLogLockTableName=databasechangeloglock"
LIQUIBASE_JAR="/opt/bahmni-lab/migrations/liquibase/lib/liquibase-1.9.5.jar"
DRIVER="org.postgresql.Driver"
CHANGE_LOG_FILE="liquibase.xml"
CLASSPATH="/etc/bahmni-lab/openelis.war"

if [  -f "$CHANGE_LOG_FILE" ]
then
cd /var/www/bahmni_config/openelis/migrations/ && java $CHANGE_LOG_TABLE -jar $LIQUIBASE_JAR --classpath=$CLASSPATH --driver=$DRIVER --changeLogFile=$CHANGE_LOG_FILE --defaultSchemaName=clinlims --url=jdbc:postgresql://$OPENELIS_DB_SERVER:5432/clinlims --username=$OPENELIS_DB_USERNAME --password=$OPENELIS_DB_PASSWORD update
fi