#!/bin/sh
set -e -x
. /etc/bahmni-installer/bahmni.conf

TIME=`date +%Y%m%d_%H%M%S`

pg_dump -U clinlims  -a -t markers -t failed_events clinlims > /etc/bahmni-installer/atomfeed-backup/openelis_atomfeed_backup_$TIME.sql