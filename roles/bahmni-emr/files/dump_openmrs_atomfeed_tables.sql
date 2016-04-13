#!/bin/sh
set -e -x
. /etc/bahmni-installer/bahmni.conf

TIME=`date +%Y%m%d_%H%M%S`

mysqldump -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD openmrs markers failed_events failed_event_retry_log > /etc/bahmni-installer/backup/openmrs_atomfeed_backup_$TIME.sql