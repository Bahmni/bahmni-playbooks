#!/usr/bin/env bash
OUTPUT="$(date)"

 echo "Content-type: application/json"
 echo ""
 echo "{\"date\": \"$OUTPUT\"}"