#!/usr/bin/env bash
OUTPUT=$(date +"%D %r %Z")

 echo "Content-type: application/json"
 echo ""
 echo "{\"date\": \"$OUTPUT\"}"