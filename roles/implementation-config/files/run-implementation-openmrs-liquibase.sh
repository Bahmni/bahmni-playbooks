#!/bin/sh
set -e -x

. /etc/bahmni-installer/bahmni.conf

CHANGE_LOG_TABLE="-Dliquibase.databaseChangeLogTableName=liquibasechangelog -Dliquibase.databaseChangeLogLockTableName=liquibasechangeloglock -DschemaName=openmrs"
LIQUIBASE_JAR="/opt/openmrs/openmrs/WEB-INF/lib/liquibase-core-2.0.5.jar"
DRIVER="com.mysql.jdbc.Driver"
CLASSPATH=`ls /opt/openmrs/openmrs/WEB-INF/lib/mysql-connector-java-*.jar`
CHANGE_LOG_FILE="liquibase.xml"

if [  -f "/var/www/bahmni_config/openmrs/migrations/$CHANGE_LOG_FILE" ]; then
cd /var/www/bahmni_config/openmrs/migrations
java $CHANGE_LOG_TABLE  -jar $LIQUIBASE_JAR --driver=$DRIVER --classpath=$CLASSPATH --changeLogFile=$CHANGE_LOG_FILE --url=jdbc:mysql://$OPENMRS_DB_SERVER:3306/openmrs --username=$OPENMRS_DB_USERNAME --password=$OPENMRS_DB_PASSWORD update
cd -
else
echo "File not found: '/var/www/bahmni_config/openmrs/migrations/$CHANGE_LOG_FILE'"
fi
