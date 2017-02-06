#!/bin/sh
#set -e -x
. /etc/bahmni-installer/bahmni.conf

#full_backp_dir=`ls -1 $1 | grep '_full'`
#incr_dirs=`ls -1 $1 | grep '_incr'|sort`


full_backp_dir=`ls -1 $1|grep -B 10000 ${2} | grep '_full' | tail -1`
incr_dirs=`ls -1 $1|grep -A100000 ${full_backp_dir} |grep -B10000 $2 |grep '_incr'|sort`

#folderArray=(${folders/// })

echo $full_backp_dir
echo $incr_dirs
restore_point=$2
line=`grep $2 $1/backup-info.log`
if [[  -z "${line// }" ]]; then
   echo "Did not found the restore point in backup dir"
   exit
fi

type=`echo $line|cut -d ' ' -f 2`


declare -a arr
arr=()
if [ "$type" == "incr" ]
then
   while [ "$type" == "incr" ]
   do
      item=`echo $line|cut -d ' ' -f 3`
      arr=($item)
      arr=($item "${arr[@]}")
      parent=`echo $line|cut -d ' ' -f 4`
      line=`grep $parent $1/backup-info.log`
      type=`echo $line|cut -d ' ' -f 2`
   done
fi

if [ "$type" == "full" ]
then
   full_backup_dir=`echo $line|cut -d ' ' -f 3`
fi

echo $full_backp_dir
echo $incr_dirs

`rm -rf /tmp/restore_dir/`
`mkdir -p /tmp/restore_dir/base/`

`cp -rf $1/$full_backp_dir/* /tmp/restore_dir/base/`


for dir in $incr_dirs
do
  `cp -rf $1/$dir /tmp/restore_dir/`

done

#incr_dir_array=(${incr_dirs// / })
#echo ${incr_dir_array[1]}

# Validation: Check if restore point exists

# Prepare full backup
echo "xtrabackup --prepare --apply-log-only --target-dir=/tmp/restore_dir/base/"
`xtrabackup --prepare --apply-log-only --target-dir=/tmp/restore_dir/base/`

# Prepare Incremental backup till the restore point

for dir in $incr_dirs
do
   echo $dir
   if [ "$dir" =  "$2" ]
   then
      # Run the prepare step with out apply log
      echo "xtrabackup --prepare  --target-dir=/tmp/restore_dir/base/ --incremental-dir=/tmp/restore_dir/$dir"
      `xtrabackup --prepare  --target-dir=/tmp/restore_dir/base/ --incremental-dir=/tmp/restore_dir/$dir`
      break
   fi
   
   # Run the preare step with apply log
   echo "xtrabackup --prepare --apply-log-only --target-dir=/tmp/restore_dir/base/ --incremental-dir=/tmp/restore_dir/$dir"
  `xtrabackup --prepare --apply-log-only --target-dir=/tmp/restore_dir/base/ --incremental-dir=/tmp/restore_dir/$dir`

done

#`rsync -arP --del /tmp/restore_dir/$full_backp_dir/openmrs/ /var/lib/mysql/openmrs/`
#`rm -rf /tmp/restore_dir/`
#echo ${incr_dirs[1]}

