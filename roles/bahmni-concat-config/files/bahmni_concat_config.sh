#!/bin/bash


declare -a paths=("/var/www/bahmni_config/openmrs/apps/home/home.json"
                "/var/www/bahmni_config/openmrs/apps/registration/registration.json"
                "/var/www/bahmni_config/openmrs/apps/clinical/clinical.json"
                "/var/www/bahmni_config/openmrs/apps/dbNameCondition/dbNameCondition.json")

for i in "${paths[@]}"
do
   if [ -f $i ]
   then
       rm -rf $i
   fi
done

python /tmp/bahmni_concat_config.py