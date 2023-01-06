#!/bin/bash

curl -X PATCH https://cloud.docker.com/v2/repositories/rod4n4m1/kanivete \
  -H 'Content-Type: application/json' \
  -H 'Authorization: JWT ${API_TOKEN}' \
  -d '${OVERVIEW}'