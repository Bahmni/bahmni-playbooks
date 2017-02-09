#!/bin/bash
time=$(cat $1/backup_info.txt  |awk -v id="$2" '{if( $3 == id) print $1}')
backup_time=$(echo $time|awk 'BEGIN { FIELDWIDTHS = "4 2 2 2 2 2" } { printf "%s-%s-%s %s:%s:%s\n", $1, $2, $3, $4, $5, $6 }')
sudo -u postgres pgbackrest --stanza=demo --delta --type=time  "--target=$backup_time"    --set=$2   --log-level-console=detail restore 2>>$3  