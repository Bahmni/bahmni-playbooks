#!/bin/sh
#set -e -x
. /etc/bahmni-installer/bahmni.conf

full_backp_dir=`ls -1 $1 | grep '_full'`
incr_dirs=`ls -1 $1 | grep '_incr'|sort`

#folderArray=(${folders/// })

echo $full_backp_dir
echo $incr_dirs

incr_dir_array=(${incr_dirs// / })
echo ${incr_dir_array[1]}

# Validation: Check if restore point exisits


# Prepare full backup
echo "xtrabackup --prepare --apply-log-only --target-dir=$1/$full_backp_dir"
`xtrabackup --prepare --apply-log-only --target-dir=$1/$full_backp_dir`

# Prepare Incremental backup till the restore point

for dir in $incr_dirs
do
   echo $dir
   if [ "$dir" =  "$2" ]
   then
      # Run the prepare step with out apply log
      echo "xtrabackup --prepare  --target-dir=$1/$full_backp_dir --incremental-dir=$1/$dir"
      `xtrabackup --prepare  --target-dir=$1/$full_backp_dir --incremental-dir=$1/$dir`
      break
   fi
   
   # Run the preare step with apply log
   echo "xtrabackup --prepare --apply-log-only --target-dir=$1/$full_backp_dir --incremental-dir=$1/$dir"
  `xtrabackup --prepare --apply-log-only --target-dir=$1/$full_backp_dir --incremental-dir=$1/$dir`

done

#echo ${incr_dirs[1]}

