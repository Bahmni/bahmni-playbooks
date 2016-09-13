#!/bin/sh
set -e -x
. /etc/bahmni-installer/bahmni.conf

TIME=`date +%Y%m%d_%H%M%S`

pg_dump -U pacs -a -t markers -t failed_events bahmni_pacs > /etc/bahmni-installer/atomfeed-backup/pacs_integration_atomfeed_backup_$TIME.sql