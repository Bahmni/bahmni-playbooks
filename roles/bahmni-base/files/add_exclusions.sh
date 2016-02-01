#!/usr/bin/env bash

if [[ `grep "^exclude=" /etc/yum.conf` == '' ]]; then
    echo 'exclude=bahmni* openmrs*' >> /etc/yum.conf;
fi
