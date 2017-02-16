#!/bin/bash
number_of_blocks=$(pgbackrest info|awk -v RS=  'END{print NR}')
block_number=1
echo -e "Timestamp\tStarategy\tBackup_ID\tParent_ID"  >$1/backup_info.txt
while [ $block_number -le $number_of_blocks ]
do
    backup_type=""
    backup_id=""
    timestamp=""
    backup_reference=""
    block=`pgbackrest info|awk -v b="$block_number" '!$0{i++;next;} i==b;i>b{exit;}'`
    backup_type=$(echo -e  $block|grep backup: |cut -d " " -f1)
    backup_id=$(echo $block|grep backup:|cut -d " " -f3)
    timestamp=`echo $block|awk '/timestamp:/{gsub("-","",$11);gsub(":","",$12); print $11$12}'`
    backup_reference=`echo -e  $block|awk '/list:/{print $29}'`
    echo -e $timestamp "\t" $backup_type "\t" $backup_id "\t" $backup_reference >>$1/backup_info.txt
    block_number=$((block_number+1))
done