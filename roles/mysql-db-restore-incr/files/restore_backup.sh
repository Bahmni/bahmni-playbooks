#!/bin/sh
set -e -x

full_backup_dir=""

#folderArray=(${folders/// })

restore_point=$2
search_string=`cat $1/backup_info.txt |awk -v id="$restore_point" '{if( $3 == id) print $3}'`
if [ -z $search_string ]
 then
   echo "Did not found the restore point in backup dir"
   exit -1
fi

type=`cat $1/backup_info.txt |awk -v id="$restore_point" '{if( $3 == id) print $2}'`
echo $type

declare -a arr
arr=()
parent=$restore_point
while [ "$type" == "incr" ]
do
      item=`cat $1/backup_info.txt |awk -v id="$parent" '{if( $3 == id) print $3}'`
      arr=($item ${arr[@]})
      echo ${arr[@]}
      parent=`cat $1/backup_info.txt |awk -v id="$parent" '{if( $3 == id) print $4}'`
      if [ ! -d "$1/$parent" ]; then
         echo "Dependent restore files $1/$parent not present"
         exit -1
      fi
      type=`cat $1/backup_info.txt |awk -v id="$parent" '{if( $3 == id) print $2}'`
done

if [ "$type" == "full" ]
then
   full_backup_dir=`cat $1/backup_info.txt |awk -v id="$parent" '{if( $3 == id) print $3}'`
fi


echo $full_backup_dir
incr_dirs=${arr[@]}
echo $incr_dirs
echo ${arr[@]}

`rm -rf /tmp/restore_dir/`
`mkdir -p /tmp/restore_dir/base/`

echo "cp -rf $1/$full_backup_dir/ /tmp/restore_dir/base/"
`cp -rf $1/$full_backup_dir/* /tmp/restore_dir/base/`

for dir in $incr_dirs
do
  `cp -rf $1/$dir /tmp/restore_dir/`

done

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

