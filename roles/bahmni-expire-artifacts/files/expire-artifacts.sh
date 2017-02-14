#!/bin/bash
if [ $(ls -t $2| grep $1 | tail -n +$(($3)) | wc -l) -gt 0  -a $3 -gt 0 ]
   then
      for files in $(ls -t $2 | grep $1 | tail -n +$(($3+1)))
      do
        rm -rf $2/$files
      done
fi
