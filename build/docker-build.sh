#!/bin/bash
export APP_NAME="kanivete"
export VERSION="0.1.1"
export USER_NAME="rod4n4m1"

docker login
docker build . -t $USER_NAME/$APP_NAME:$VERSION
docker push $USER_NAME/$APP_NAME:$VERSION