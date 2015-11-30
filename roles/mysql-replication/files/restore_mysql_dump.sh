#!/bin/sh
set -e -x
. /etc/bahmni-installer/bahmni.conf

mysql -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD < '/opt/mysql-replication/mysql_dump.sql'