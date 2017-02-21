#!/bin/sh
set -e -x
for frmname in /tmp/restore_dir/base/$3/*.ibd
do
    tablename=$(find $frmname -printf "%f\n"|sed s/.ibd$//)

    # ALTER TABLE ... DISCARD TABLESPACE - junks those pesky datafiles we don't want.
    mysql -B -u $1 -p$2 $3 -e "ALTER TABLE $tablename $4 TABLESPACE"
done
