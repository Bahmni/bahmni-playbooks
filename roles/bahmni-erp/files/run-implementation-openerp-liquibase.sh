#!/bin/sh
set -e -x
. /etc/bahmni-installer/bahmni.conf

CHANGE_LOG_TABLE="-Dliquibase.databaseChangeLogTableName=liquibasechangelog -Dliquibase.databaseChangeLogLockTableName=liquibasechangeloglock"
LIQUIBASE_JAR="/opt/bahmni-erp-connect/bahmni-erp-connect/WEB-INF/lib/liquibase-core-2.0.3.jar"
DRIVER="org.postgresql.Driver"
CHANGE_LOG_FILE="liquibase.xml"
CLASSPATH="/etc/bahmni-erp-connect/openerp-atomfeed-service.war"

if [  -f "/var/www/bahmni_config/openerp/migrations/$CHANGE_LOG_FILE" ]; then
cd /var/www/bahmni_config/openerp/migrations
java $CHANGE_LOG_TABLE -jar $LIQUIBASE_JAR --classpath=$CLASSPATH --driver=$DRIVER --changeLogFile=$CHANGE_LOG_FILE --defaultSchemaName=public --url=jdbc:postgresql://$OPENERP_DB_SERVER:5432/openerp --username=$OPENERP_DB_USERNAME --password=$OPENERP_DB_PASSWORD update
cd -
else
echo "File not found: '/var/www/bahmni_config/openerp/migrations/$CHANGE_LOG_FILE'"
fi
