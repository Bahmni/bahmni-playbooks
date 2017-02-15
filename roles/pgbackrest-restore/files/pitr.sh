#!/bin/bash

time=$(cat $1/backup_info.txt  |awk -v id="$2" '{if( $3 == id) print $1}')
if [ -z $time ]
 then
   echo "Did not find the restore point in backup dir"
   exit -1
fi
time=$(date +'%Y%m%d%H%M%S')
backup_time=$(echo $time|awk 'BEGIN { FIELDWIDTHS = "4 2 2 2 2 2" } { printf "%s-%s-%s %s:%s:%s\n", $1, $2, $3, $4+1, $5, $6 }')
sudo -u postgres pgbackrest --stanza=bahmni-postgres --delta --type=time  "--target=$backup_time"    --set=$2   --log-level-console=detail restore 2>>$3  