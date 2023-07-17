#!/bin/bash
source building.env

docker login
docker build . -t $USER_NAME/$APP_NAME:$VERSION
docker push $USER_NAME/$APP_NAME:$VERSION