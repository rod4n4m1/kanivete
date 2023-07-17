#!/bin/bash

export API_TOKEN=`curl -s -X POST \
-H "Content-Type: application/json" \
-d '{"username": "${username}", "password": "${password}"}' \
https://hub.docker.com/v2/users/login/ | jq -r .token`
export OVERVIEW=`jq -n --arg msg "$(<../README.md)" '{"registry":"registry-1.docker.io","full_description": $msg }'`

curl -X PATCH https://cloud.docker.com/v2/repositories/${image} \
  -H 'Content-Type: application/json' \
  -H 'Authorization: JWT ${API_TOKEN}' \
  -d '${OVERVIEW}'